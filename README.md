StepMania: On The Chill
=======================

![StepMania: On The Chill title screen](http://psmay.github.io/stepmania-on-the-chill-theme/screenshots/2014-11-06/03-title-b.jpg)

Introduction
------------

**StepMania: On The Chill** is a theme for StepMania 5.

This version is based on the `legacy` (`default` before 5.1) theme by Midiman, and is actually intended to remain close enough to track most fixes/updates that apply to the original.

The original theme
------------------

This is a fork of the `legacy` theme from the StepMania project.

This branch is based on the version of `legacy` from the 5.1.0-b2 release of StepMania and is developed and tested against that release.

Differences from the original
-----------------------------

The notable changes include:

*   Blueness—blue, blue, and more blue. Nearly everything in the fiery yellow/orange characteristic of the `legacy` theme has been recolored to icy blues (and, where contrast is needed, snowy whites) here.
    *   There are still spots I've missed; this is a work in progress.
*   New artwork (see SVG files in `_assets`) to coincide with an in-progress cabinet artwork project I have going.
    *   Credits screen logos.
        *   To represent the StepMania project in general, lightly retouched/simplified vectorization of Plaguefox's well-known logotype.
            *   (This logo is to credit producers of the game and does not signify their endorsement of this theme.)
            *   The end caps of the strokes and the dot on the "i" are circular rather than elliptical.
            *   The stroke width was played with, though the result is similar to the original.
            *   Tried a novel composition of the red up-right arrow icon with this logotype.
                *   (which I like, but you can decide whether it's a hit or a miss.)
        *   To represent SSC, lightly simplified vectorization of the SSC logo.
            *   (This logo is to credit producers of the game and does not signify their endorsement of this theme.)
            *   The logo is geometrically simple enough that my version has to be held quite close to the original to notice any differences.
        *   To represent my contribution, the "rhythm.hgk" logo.
    *   "Advanced Rhythm Simulation — StepMania: On The Chill" logotype.
        *   "Advanced Rhythm Simulation" (as opposed to "Advanced Rhythm Game" present on some logos) adds a touch of Engrishness to the title.
        *   Uses the StepTech typeface (see below).
    *   Up-right icon arrow rendered in halftone (for a touch of early-DDR-reminiscent flair).
*   Horizontally parallax-scrolled blue clouds replace the chessboard pattern for menu screen backgrounds.
*   Vertically parallax-scrolled blue clouds replace the scrolling grid pattern for How To Play screen background.

Still to do
-----------

*   Change `Common fallback background.png` to stick out less. It shouldn't actually say "no background"; it should show a generic background that goes nicely with the rest of the screen.
*   Change the larger text-based images (like "1st Stage", "Game Over", but not like "Perfect", "OK!") to use StepTech typeface (see below), perhaps combining with a perspective effect as with the logotype itself.
    *   Where it makes sense stylistically, use all-lowercase text as with the logotype.

### In the upstream

Problems that could use some addressing in the original theme include:

*   Many .png resources appear to be unused in the current version of the theme.
    *   The `_SelectIcon*.png` files, for example, are now automatically rendered from i18n'd text plus a generic background image.
*   There's an MP3 file in `Sounds` (and it should probably be removed instead of converted).
*   `_howto *.png` should be updated; they show screens of the old `sm-ssc` project page.
*   Add higher-res versions of the existing sans-serif bitmap fonts. There are places where text is displayed so much larger than the intended scale that the game begins to lose its polish.

StepTech typeface
-----------------

The typeface used for the logotype has a working title of "StepTech" (or "StepTech 1st Mix"). It was entirely created by me and does not currently exist in any form other than raw glyphs in an SVG file. I've tried to work on making it available as an actual font (e.g. using FontForge), but there are some catches to the process. This font being based very strictly on a particular grid, and me being a stickler for precision, there has been room for chafing. Also, making the uppercase glyphs and glyphs with combining marks look as good as the lowercase is difficult in places.

The morbidly curious may be able to tease some SVGs and/or an actual font file out of the code in the [steptech-font-generator](https://github.com/psmay/steptech-font-generator) repo.

Credits and license
-------------------

### Original theme

This theme is based heavily on the StepMania 5 `legacy` theme by Midiman of SSC. Being part of the main StepMania project, it is presumably under the MIT license.

### Logotypes

#### SM:OTC

"Advanced Rhythm Simulation — StepMania: On The Chill" logotype copyright © 2014 Peter S. May

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 United States License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/us/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

#### Derived logos

##### `Common splash.png` (Plaguefox arrow/"worm" logo)

Some artwork for this theme is derived from the `legacy` theme's `Common splash.png`. That image includes among its elements:

*   A red up- and right-pointed arrow drawn in broad strokes with circular end caps.
*   A blue logotype consisting of the word "stepmania", in lower case, using a round-cornered, squarish typeface with elliptical end caps.

The credits screen and part of the concept artwork contains a logo using the same elements with simplifications and a different arrangement realized in vectors (SVG):

*   The new logotype uses circular end caps rather than elliptical.
*   The new logotype's stroke width varies slightly from the original.
*   The arrow element is enlarged and moved behind the logotype.
*   Broad white outlines are added to the elements.
*   The sheen effects drawn on the original elements are replaced with simple gradient fills.

Additionally, the generic background and part of the concept artwork contains a logo using the arrow element of the logo having been encircled and rendered with a halftone effect.

The original artwork either was created by or derives heavily from a logo produced by Plaguefox, and presumably belongs to the StepMania project at large. It is used by the StepMania project and is thereby presumably MIT-licensed, though it is not clear by whom.

I have obtained no special permission to use or modify the work and I do not assert any legal claim that I am the owner; consult the owner of the original artwork for permission to use my derived variant.

##### SSC

The credits screen and part of the concept artwork contains a logo for SSC (that is, [the spinal shark collective](http://ssc.ajworld.net/)) that is based on the original `ssc (doubleres).png` (from SM5's `_fallback` theme) with minor simplifications realized in vectors (SVG).

The original artwork belongs to SSC. It is used by the StepMania project, but given that it is the logo of a group it should probably be treated more as a trademark than a copyrightable work—that is, even if modifying the artwork is legal, using it in a way for which they haven't given explicit permission may be considered bad faith (or, in a broader sense, illegal). My inclusion of it here is to give the group credit for their part in producing the game, and is placed so that it won't be mistaken as something else (such as an endorsement of this theme).

I have obtained no special permission to use or modify the work and I do not assert any legal claim that I am the owner; consult the owner of the original artwork for permission to use my derived variant.
