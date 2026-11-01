# Changelog

## 0.1.0

The first release, extracted from [blit](https://github.com/radiosilence/blit), where it translates the site into 36 locales.

### Added

- **The gettext vocabulary in Askama templates.** `__`, `__p`, `__n` and `__np` resolve to methods once a template implements `Translate`. The English is the msgid, so an untranslated string renders in the source language. `%{name}` placeholders are filled by name, and the `h` variants carry markup whose tags code registers and everything else is escaped.
- **Extraction with Askama's own parser, and merging into `.po` files.** A call whose English is not a string literal fails extraction with its line. Merging keeps translations, comments, flags and header metadata, moves a reworded message's translation to its new id as fuzzy, and names every message it deletes.
- **Plural forms from CLDR.** `icu_plurals` picks the `msgstr[n]` for a count. A catalogue whose `Plural-Forms` header disagrees with CLDR, in the number of forms or the form any count selects, fails to load.
