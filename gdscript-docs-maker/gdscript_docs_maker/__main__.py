"""Merges JSON dumped by Godot's gdscript language server or converts it to a markdown
document.
"""
import json
import logging
import os
import sys
from argparse import Namespace
from itertools import repeat
from typing import List

import pkg_resources

from .modules import command_line
from .modules.config import LOG_LEVELS, LOGGER
from .modules.convert_to_markdown import convert_to_markdown
from .modules.gdscript_objects import GDScriptClasses, ProjectInfo
from .modules.make_markdown import MarkdownDocument


def main():
    args: Namespace = command_line.parse()

    if args.version:
        print(pkg_resources.get_distribution("gdscript-docs-maker").version)
        sys.exit()

    logging.basicConfig(level=LOG_LEVELS[min(args.verbose, len(LOG_LEVELS) - 1)])
    LOGGER.debug("Output format: {}".format(args.format))
    json_files: List[str] = [f for f in args.files if f.lower().endswith(".json")]
    LOGGER.info("Processing JSON files: {}".format(json_files))
    for f in json_files:
        with open(f, "r") as json_file:
            data: list = json.loads(json_file.read())
            project_info: ProjectInfo = ProjectInfo.from_dict(data)
            classes: GDScriptClasses = GDScriptClasses.from_dict_list(data["classes"])
            classes_count: int = len(classes)

            LOGGER.info(
                "Project {}, version {}".format(project_info.name, project_info.version)
            )
            LOGGER.info(
                "Processing {} classes in {}".format(classes_count, os.path.basename(f))
            )

            documents: List[MarkdownDocument] = convert_to_markdown(
                classes, args, project_info
            )
            if args.dry_run:
                LOGGER.debug("Generated {} markdown documents.".format(len(documents)))
                list(map(lambda doc: LOGGER.debug(doc), documents))
            else:
                if not os.path.exists(args.path):
                    LOGGER.info("Creating directory " + args.path)
                    os.mkdir(args.path)

                LOGGER.info(
                    "Saving {} markdown files to {}".format(len(documents), args.path)
                )
                list(map(save, documents, repeat(args.path)))


def save(
    document: MarkdownDocument, dirpath: str,
):
    path: str = os.path.join(dirpath, document.get_filename())
    with open(path, "w") as file_out:
        LOGGER.debug("Saving markdown file " + path)
        file_out.write(document.as_string())


if __name__ == "__main__":
    main()
