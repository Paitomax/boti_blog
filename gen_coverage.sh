#!/bin/bash

flutter test --coverage
lcov --remove coverage/lcov.info -o coverage/lcov_filtered.info \
	*data_provider* \
       	*repository* \
	*database.dart \
	*event.dart \
	*state.dart \
	app_routes.dart \
	app_colors.dart \
	*.g.dart
genhtml coverage/lcov_filtered.info -o coverage/html
