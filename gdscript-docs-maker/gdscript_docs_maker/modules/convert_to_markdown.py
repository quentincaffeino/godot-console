"""Parses the JSON data from Godot as a dictionary and outputs markdown
documents

"""
import re
from argparse import Namespace
from typing import List

from . import hugo
from .command_line import OutputFormats
from .config import LOGGER
from .gdscript_objects import Element, GDScriptClass, GDScriptClasses, ProjectInfo
from .hugo import HugoFrontMatter
from .make_markdown import (
    MarkdownDocument,
    MarkdownSection,
    make_bold,
    make_code_block,
    make_comment,
    make_heading,
    make_link,
    make_table_header,
    make_table_row,
    surround_with_html,
    wrap_in_newlines,
)


def convert_to_markdown(
    classes: GDScriptClasses, arguments: Namespace, info: ProjectInfo
) -> List[MarkdownDocument]:
    """Takes a list of dictionaries that each represent one GDScript class to
    convert to markdown and returns a list of markdown documents.

    """
    markdown: List[MarkdownDocument] = []
    if arguments.make_index:
        markdown.append(_write_index_page(classes, info))
    for entry in classes:
        markdown.append(_as_markdown(classes, entry, arguments))
    return markdown


def _as_markdown(
    classes: GDScriptClasses, gdscript: GDScriptClass, arguments: Namespace
) -> MarkdownDocument:
    """Converts the data for a GDScript class to a markdown document, using the command line
    options."""

    content: List[str] = []
    output_format: OutputFormats = arguments.format

    name: str = gdscript.name
    if "abstract" in gdscript.metadata.tags:
        name += " " + surround_with_html("(abstract)", "small")

    if output_format == OutputFormats.HUGO:
        front_matter: HugoFrontMatter = HugoFrontMatter.from_data(gdscript, arguments)
        content += front_matter.as_string_list()

    content += [
        make_comment(
            "Auto-generated from JSON by GDScript docs maker. "
            "Do not edit this document directly."
        )
        + "\n"
    ]

    if output_format == OutputFormats.MARDKOWN:
        content += [*make_heading(name, 1)]
    if gdscript.extends:
        extends_list: List[str] = gdscript.get_extends_tree(classes)
        extends_links = [make_link(entry, "../" + entry) for entry in extends_list]
        content += [make_bold("Extends:") + " " + " < ".join(extends_links)]
        description = _replace_references(classes, gdscript, gdscript.description)
        content += [*MarkdownSection("Description", 2, [description]).as_text()]

    content += _write_class(classes, gdscript, output_format, 2)
    if gdscript.signals:
        content += MarkdownSection(
            "Signals", 2, _write_signals(classes, gdscript, output_format)
        ).as_text()

    if gdscript.sub_classes:
        content += make_heading("Sub-classes", 2)
    for cls in gdscript.sub_classes:
        content += _write_class(classes, cls, output_format, 3, True)

    return MarkdownDocument(gdscript.name, content)


def _write_class(
    classes: GDScriptClasses,
    gdscript: GDScriptClass,
    output_format: OutputFormats,
    heading_level: int,
    is_inner_class: bool = False,
) -> List[str]:
    markdown: List[str] = []
    if is_inner_class:
        markdown += make_heading(gdscript.name, heading_level)
    for attribute, title in [
        ("enums", "Enumerations"),
        ("members", "Property Descriptions"),
        ("functions", "Method Descriptions"),
    ]:
        if not getattr(gdscript, attribute):
            continue
        markdown += MarkdownSection(
            title,
            heading_level + 1 if is_inner_class else heading_level,
            _write(attribute, classes, gdscript, output_format),
        ).as_text()
    return markdown


def _write_summary(gdscript: GDScriptClass, key: str) -> List[str]:
    element_list = getattr(gdscript, key)
    if not element_list:
        return []
    markdown: List[str] = make_table_header(["Type", "Name"])
    return markdown + [make_table_row(item.summarize()) for item in element_list]


def _write(
    attribute: str,
    classes: GDScriptClasses,
    gdscript: GDScriptClass,
    output_format: OutputFormats,
    heading_level: int = 3,
) -> List[str]:
    assert hasattr(gdscript, attribute)

    markdown: List[str] = []
    for element in getattr(gdscript, attribute):
        # assert element is Element
        markdown.extend(make_heading(element.get_heading_as_string(), heading_level))
        markdown.extend([make_code_block(element.signature), ""])
        markdown.extend(element.get_unique_attributes_as_markdown())
        markdown.append("")
        description: str = _replace_references(classes, gdscript, element.description)
        markdown.append(description)

    return markdown


def _write_signals(
    classes: GDScriptClasses, gdscript: GDScriptClass, output_format: OutputFormats
) -> List[str]:
    return wrap_in_newlines(
        [
            "- {}: {}".format(
                s.signature, _replace_references(classes, gdscript, s.description)
            )
            for s in gdscript.signals
        ]
    )


def _write_index_page(classes: GDScriptClasses, info: ProjectInfo) -> MarkdownDocument:
    title: str = "{} ({})".format(info.name, surround_with_html(info.version, "small"))
    content: List[str] = [
        *MarkdownSection(title, 1, info.description).as_text(),
        *MarkdownSection("Contents", 2, _write_table_of_contents(classes)).as_text(),
    ]
    return MarkdownDocument("index", content)


def _write_table_of_contents(classes: GDScriptClasses) -> List[str]:
    toc: List[str] = []

    by_category = classes.get_grouped_by_category()

    for group in by_category:
        indent: str = ""
        first_class: GDScriptClass = group[0]
        category: str = first_class.category
        if category:
            toc.append("- {}".format(make_bold(category)))
            indent = "  "

        for gdscript_class in group:
            link: str = indent + "- " + make_link(
                gdscript_class.name, gdscript_class.name
            )
            toc.append(link)

    return toc


def _replace_references(
    classes: GDScriptClasses, gdscript: GDScriptClass, description: str
) -> str:
    """Finds and replaces references to other classes or methods in the
    `description`."""
    ERROR_MESSAGES = {
        "class": "Class {} not found in the class index.",
        "member": "Symbol {} not found in {}. The name might be incorrect.",
    }
    ERROR_TAIL = "The name might be incorrect."

    references: re.Match = re.findall(r"\[.+\]", description)
    for reference in references:
        # Matches [ClassName], [symbol], and [ClassName.symbol]
        match: re.Match = re.match(
            r"\[([A-Z][a-zA-Z0-9]*)?\.?([a-z0-9_]+)?\]", reference
        )
        if not match:
            continue

        class_name, member = match[1], match[2]

        if class_name and class_name not in classes.class_index:
            LOGGER.warning(ERROR_MESSAGES["class"].format(class_name) + ERROR_TAIL)
            continue

        if member and class_name:
            if member not in classes.class_index[class_name]:
                LOGGER.warning(
                    ERROR_MESSAGES["member"].format(member, class_name) + ERROR_TAIL
                )
                continue
        elif member and member not in classes.class_index[gdscript.name]:
            LOGGER.warning(
                ERROR_MESSAGES["member"].format(member, gdscript.name) + ERROR_TAIL
            )
            continue

        display_text, path = "", "../"
        if class_name:
            display_text, path = class_name, class_name
        if class_name and member:
            display_text += "."
            path += "/"
        if member:
            display_text += member
            path += "#" + member.replace("_", "-")

        link: str = make_link(display_text, path)
        description = description.replace(reference, link, 1)
    return description
