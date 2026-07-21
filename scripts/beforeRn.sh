#!/bin/bash
cd app
dart run flutter_launcher_icons
dart run flutter_native_splash:create
# generate i18n files
dart run build_runner build
