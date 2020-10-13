"""Merges a JSON reference file dumped by Godot's language server into an edited JSON
reference data file.

Use this to update and extend docstrings from the Godot source code.
"""
import json


def merge_into(godot_json: str, target_json: str) -> str:
    godot_data: dict = json.loads(godot_json)
    target_data: dict = json.loads(target_json)
    merged_data: dict = {**target_data, **godot_data}
    return json.dumps(merged_data, indent=4)
