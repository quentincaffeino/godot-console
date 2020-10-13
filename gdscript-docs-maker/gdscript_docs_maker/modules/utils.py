"""Generic utility functions for GDScript docs maker."""


def build_re_pattern(tag_name: str) -> str:
    """Returns a string pattern to match for JSDoc-style tags, with the form @tag_name
    or @tag_name - value
    The match pattern has a match group for the value."""
    return "^@{} ?-? ?(.+)?".format(tag_name)
