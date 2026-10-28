"""Shared pre-write texture policy for new Forest preview builds."""


def validate_texture_policy(coherent_tmp_face):
    if coherent_tmp_face:
        raise ValueError('--coherent-tmp-face rewrites the original font atlas and is disabled for the current texture-preserving workflow')
