"""General functions and utilities to write markdown documents.
"""
import re
from dataclasses import dataclass
from typing import List, Any


@dataclass
class MarkdownDocument:
    title: str
    content: List[str]

    def get_filename(self):
        return self.title + ".md"

    def as_string(self) -> str:
        """Removes duplicate empty lines from the document and returns it as a
string."""
        text: str = "\n".join(self.content)
        return re.sub(r"\n\n+", "\n\n", text)

    def __repr__(self):
        return "MarkdownDocument(title={}, content={})".format(
            self.title, "\\n".join(self.content)[:120] + "..."
        )


class MarkdownSection:
    def __init__(self, title: str, heading_level: int, content: List[str]):
        """Represents a section of a markdown document.

        Keyword Arguments:
        title: str         --
        heading_level: int --
        content: List[str] -- content of the section
        """
        self.title: List[str] = make_heading(title, heading_level)
        self.content: List[str] = content

    def is_empty(self) -> bool:
        return not self.content

    def as_text(self) -> List[str]:
        return self.title + self.content if not self.is_empty() else []


def wrap_in_newlines(markdown: List[str] = []) -> List[str]:
    return ["", *markdown, ""]


def make_heading(line: str, level: int = 1) -> List[str]:
    """Returns the line as a markdown heading, surrounded by two empty lines."""
    hashes = "#" * level
    return ["", " ".join([hashes, escape_markdown(line)]), ""]


def escape_markdown(text: str) -> str:
    """Escapes characters that have a special meaning in markdown, like *_-"""
    characters: str = "*_-+`"
    for character in characters:
        text = text.replace(character, "\\" + character)
    return text


def make_bold(text: str) -> str:
    """Returns the text surrounded by **"""
    return "**" + text + "**"


def make_italic(text: str) -> str:
    """Returns the text surrounded by *"""
    return "*" + text + "*"


def make_code_inline(text: str) -> str:
    """Returns the text surrounded by `"""
    return "`" + text + "`"


def make_code_block(text: str, language: str = "gdscript") -> str:
    """Returns the text surrounded by `"""
    return "```{}\n{}\n```".format(language, text)


def make_link(description: str, target: str) -> str:
    return "[{}]({})".format(description, target)


def make_list(
    strings: List[str], is_numbered: bool = False, indent_level: int = 0
) -> List[str]:
    """Returns a bullet or ordered list from strings."""
    indent: str = "  " * indent_level

    def make_list_item(index: int, string: str) -> str:
        return indent + "{} {}".format(index + "." if is_numbered else "-", string)

    return [make_list_item(i, string) for i, string in enumerate(strings, start=1)]


def make_table_header(cells: List[str]) -> List[str]:
    return [make_table_row(cells), " --- |" * (len(cells) - 1) + " --- "]


def make_table_row(cells: List[str]) -> str:
    return " | ".join(cells)


def make_comment(text: str) -> str:
    return "<!-- {} -->".format(text)


def surround_with_html(text: str, tag: str) -> str:
    return "<{}>{}</{}>".format(tag, text, tag)
