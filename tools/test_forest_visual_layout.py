"""Registered layout guards; actual painted geometry is checked in game."""
import copy
import unittest
from forest_localization import complex_text, image_captions


def need(value, reason):
    if not value:
        raise ValueError(reason)


class VisualLayoutInputs(unittest.TestCase):
    def setUp(self):
        self.doc = dict(locale='he', residentTextLayout=True, complexText=True,
                        fonts={'face': {'asset': 'one-face'}},
                        imageCaptions={key: dict(source=source, target='Authored')
                                       for key, source in image_captions.SOURCES.items()})

    def test_body_lift_requires_reflow_and_stays_bounded(self):
        for lift in (0, 6, 22, 24):
            image_captions.validate(dict(self.doc, residentBodyTopLift=lift), need)
        with self.assertRaisesRegex(ValueError, '^resident-body-top-lift$'):
            image_captions.validate(dict(self.doc, residentBodyTopLift=25), need)
        with self.assertRaisesRegex(ValueError, '^resident-body-lift-requires-reflow$'):
            image_captions.validate(dict(self.doc, residentBodyTopLift=6, residentTextLayout=False), need)

    def test_heading_scale_has_one_owner_and_cannot_hide_text(self):
        doc = dict(self.doc, complexTextLayout={'questHeadingScale': .7, 'questHeadingShiftX': 8, 'questHeadingLift': 6})
        complex_text.validate(doc, need)
        for scale in (0, .59, 1.01, True):
            bad = copy.deepcopy(doc)
            bad['complexTextLayout']['questHeadingScale'] = scale
            with self.assertRaisesRegex(ValueError, '^complex-heading-layout-bounds$'):
                complex_text.validate(bad, need)
        with self.assertRaisesRegex(ValueError, '^one-critter-heading-scale-owner$'):
            complex_text.validate(dict(self.doc, critterHeadingScale=.8,
                                       complexTextLayout={'critterHeadingScale': .9}), need)
        with self.assertRaisesRegex(ValueError, '^registered-complex-layout$'):
            complex_text.validate(dict(self.doc, complexTextLayout={'arbitraryTransform': 1}), need)

    def test_preference_clearance_reserves_room_inside_the_frame(self):
        greek = dict(self.doc, residentBodyTopLift=22, residentPreferenceGap=10, residentBodyBottomInset=1)
        image_captions.validate(greek, need)
        for key, invalid, reason in [
            ('residentPreferenceGap', 13, 'resident-preference-gap'),
            ('residentBodyBottomInset', 0, 'resident-body-bottom-inset'),
        ]:
            with self.assertRaisesRegex(ValueError, '^'+reason+'$'):
                image_captions.validate(dict(greek, **{key: invalid}), need)
        with self.assertRaisesRegex(ValueError, '^resident-spacing-requires-reflow$'):
            image_captions.validate(dict(greek, residentTextLayout=False, residentBodyTopLift=0), need)

    def test_profile_fit_requires_the_registered_complex_adapter(self):
        complex_text.validate(dict(self.doc, residentProfileFit=True), need)
        complex_text.validate(dict(self.doc, locale='th', residentProfileFit=True), need)
        for change in ({'locale':'de'}, {'complexText':False}):
            with self.assertRaisesRegex(ValueError, '^resident-profile-fit-requires-complex-renderer$'):
                complex_text.validate(dict(self.doc, residentProfileFit=True, **change), need)


if __name__ == '__main__':
    unittest.main()
