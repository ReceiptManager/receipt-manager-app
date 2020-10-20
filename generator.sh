#!/usr/bin/env bash

# USED to generate languages and moor database scheme

LOCALIZATION_PATH="lib/local/localization.dart"
generate_local() {
    flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n $LOCALIZATION_PATH 
}

generate_local
