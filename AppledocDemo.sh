#!/bin/sh

#  AppledocDemo.sh
#  AppleDocTargetTest
#
#  Created by Looker Jules on 22/11/2011.
#  Copyright (c) 2011 The Interface Works. All rights reserved.

# 	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

#	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# AppledocDemo.sh a modified version of AppledocBuild.sh

# Shows how shell scriping can be used to provide access to values not so readily available in the standard Xcode build settings.
# The APPLEDOC_DEFAULT_<*> variables are set which in turn feed into the APPLEDOC_<*> variables which is passed as an option to appledoc.
# Any value provided for an APPLEDOC_<*> variable through the target build settings or an .xcconfig file will override the defaults in the scenario below.
# Greater control or flexibility can be achived through variations of this approch.

# Project Info.plist file based on standard Xcode <project>-Info.plist convention
PLIST_FILE="${PROJECT_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-Info.plist"

# [OPTIONS]

# PATHS

# -o, --output <path>			Output path
APPLEDOC_DEFAULT_OUTPUT=$CONFIGURATION_BUILD_DIR	# Standard Xcode build variable

APPLEDOC_OUTPUT=${APPLEDOC_OUTPUT=$APPLEDOC_DEFAULT_OUTPUT}

# PROJECT INFO

# -p, --project-name <string>		Project name
APPLEDOC_DEFAULT_PROJECT_NAME=$PROJECT_NAME			# Standard Xcode build variable

APPLEDOC_PROJECT_NAME=${APPLEDOC_PROJECT_NAME=$APPLEDOC_DEFAULT_PROJECT_NAME}

# -v, --project-version <string>	Project version
APPLEDOC_DEFAULT_PROJECT_VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "${PLIST_FILE}" 2>&1)	# Value from <project>-Info.plist

APPLEDOC_PROJECT_VERSION=${APPLEDOC_PROJECT_VERSION=$APPLEDOC_DEFAULT_PROJECT_VERSION}

# -c, --project-company <string>	Project company
XCODE_PROJECT_ORGANIZATION=$(grep ORGANIZATIONNAME ${PROJECT_DIR}/${PROJECT_NAME}.xcodeproj/project.pbxproj)	# Value from <project>.pbxproj (or any file)
PROJECT_ORGANIZATION=${XCODE_PROJECT_ORGANIZATION#*\"}		# Value from first " charater to end of string
PROJECT_ORGANIZATION=${PROJECT_ORGANIZATION%\"*}			# Value upto last " character
APPLEDOC_DEFAULT_PROJECT_COMPANY=${PROJECT_ORGANIZATION:-"Organization in Project Document not set"}	# Value from file or constant if no value from file

APPLEDOC_PROJECT_COMPANY=${APPLEDOC_PROJECT_COMPANY=$APPLEDOC_DEFAULT_PROJECT_COMPANY}

# --company-id <string>				Company UTI (i.e. reverse DNS name)
APPLEDOC_DEFAULT_COMPANY_ID=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" "${PLIST_FILE}" 2>&1)
APPLEDOC_DEFAULT_COMPANY_ID=${APPLEDOC_DEFAULT_COMPANY_ID%.*}

APPLEDOC_COMPANY_ID=${APPLEDOC_COMPANY_ID=$APPLEDOC_DEFAULT_COMPANY_ID}

# DOCUMENTATION SET INFO

# --docset-copyright <string>         [*] DocSet copyright message
APPLEDOC_DEFAULT_DOCSET_COPYRIGHT=$(/usr/libexec/PlistBuddy -c "Print NSHumanReadableCopyright" "${PLIST_FILE}" 2>&1)

APPLEDOC_DOCSET_COPYRIGHT=${APPLEDOC_DOCSET_COPYRIGHT=$APPLEDOC_DEFAULT_DOCSET_COPYRIGHT}

# MISCELLANEOUS

# --logformat <number>                Log format [0-3]
APPLEDOC_DEFAULT_LOGFORMAT=xcode
APPLEDOC_LOGFORMAT=${APPLEDOC_LOGFORMAT=$APPLEDOC_DEFAULT_LOGFORMAT}

# <paths to source dirs or files>

APPLEDOC_DEFAULT_SOURCE_DIRS=$PROJECT_DIR
APPLEDOC_SOURCE_DIRS=(${APPLEDOC_SOURCE_DIRS=$APPLEDOC_DEFAULT_SOURCE_DIRS})						# Array

# Boolean [b] option settings
# Set build setting to YES to use positive setting eg. --create-html
# Set build setting to NO (or any member of TOKENS_FOR_NO) to use negative setting eg. --no-create-html
# An unset or empty build setting will cause no option, thereby invoking the program default
TOKENS_FOR_NO="NO no No FALSE false False 0"
OptionPrefixFor () { [[ $TOKENS_FOR_NO = *$1* ]] && echo "--no"  || echo "-" ; }

# Used instead of '#' character to prevent Xcode wrongly interpreting # in
# pattern substitution as a comment and coloring subsequent commands as comments
HASH_LITERAL=$'\043'

appledoc \
${APPLEDOC_OUTPUT:+						--output				"${APPLEDOC_OUTPUT}"} \
${APPLEDOC_TEMPLATES:+					--templates				"${APPLEDOC_TEMPLATES}"} \
${APPLEDOC_DOCSET_INSTALL_PATH:+		--docset-install-path	"${APPLEDOC_DOCSET_INSTALL_PATH}"} \
${APPLEDOC_INCLUDE:+					${APPLEDOC_INCLUDE[@]/$HASH_LITERAL/--include }} \
${APPLEDOC_IGNORE:+						${APPLEDOC_IGNORE[@]/$HASH_LITERAL/--ignore }} \
${APPLEDOC_EXCLUDE_OUTPUT:+				${APPLEDOC_EXCLUDE_OUTPUT[@]/$HASH_LITERAL/--exclude-output }} \
${APPLEDOC_INDEX_DESC:+					--index-desc 			"${APPLEDOC_INDEX_DESC}"} \
\
${APPLEDOC_PROJECT_NAME:+				--project-name 			"${APPLEDOC_PROJECT_NAME}"} \
${APPLEDOC_PROJECT_VERSION:+			--project-version 		"${APPLEDOC_PROJECT_VERSION}"} \
${APPLEDOC_PROJECT_COMPANY:+			--project-company 		"${APPLEDOC_PROJECT_COMPANY}"} \
${APPLEDOC_COMPANY_ID:+					--company-id 			"${APPLEDOC_COMPANY_ID}"} \
\
${APPLEDOC_CREATE_HTML:+ 				$(OptionPrefixFor $APPLEDOC_CREATE_HTML)-create-html} \
${APPLEDOC_CREATE_DOCSET:+ 				$(OptionPrefixFor $APPLEDOC_CREATE_DOCSET)-create-docset} \
${APPLEDOC_INSTALL_DOCSET:+ 			$(OptionPrefixFor $APPLEDOC_INSTALL_DOCSET)-install-docset} \
${APPLEDOC_PUBLISH_DOCSET:+ 			$(OptionPrefixFor $APPLEDOC_PUBLISH_DOCSET)-publish-docset} \
${APPLEDOC_CLEAN_OUTPUT:+ 				$(OptionPrefixFor $APPLEDOC_CLEAN_OUTPUT)-clean-output} \
\
${APPLEDOC_KEEP_INTERMEDIATE_FILES:+ 	$(OptionPrefixFor $APPLEDOC_KEEP_INTERMEDIATE_FILES)-keep-intermediate-files} \
${APPLEDOC_KEEP_UNDOCUMENTED_OBJECTS:+ 	$(OptionPrefixFor $APPLEDOC_KEEP_UNDOCUMENTED_OBJECTS)-keep-undocumented-objects} \
${APPLEDOC_KEEP_UNDOCUMENTED_MEMBERS:+ 	$(OptionPrefixFor $APPLEDOC_KEEP_UNDOCUMENTED_MEMBERS)-keep-undocumented-members} \
${APPLEDOC_SEARCH_UNDOCUMENTED_DOC:+ 	$(OptionPrefixFor $APPLEDOC_SEARCH_UNDOCUMENTED_DOC)-search-undocumented-doc} \
${APPLEDOC_REPEAT_FIRST_PAR:+ 			$(OptionPrefixFor $APPLEDOC_REPEAT_FIRST_PAR)-repeat-first-par} \
${APPLEDOC_MERGE_CATEGORIES:+ 			$(OptionPrefixFor $APPLEDOC_MERGE_CATEGORIES)-merge-categories} \
${APPLEDOC_KEEP_MERGED_SECTIONS:+ 		$(OptionPrefixFor $APPLEDOC_KEEP_MERGED_SECTIONS)-keep-merged-sections} \
${APPLEDOC_PREFIX_MERGED_SECTIONS:+ 	$(OptionPrefixFor $APPLEDOC_PREFIX_MERGED_SECTIONS)-prefix-merged-sections} \
${APPLEDOC_EXPLICIT_CROSSREF:+ 			$(OptionPrefixFor $APPLEDOC_EXPLICIT_CROSSREF)-explicit-crossref} \
${APPLEDOC_CROSSREF_FORMAT:+			--crossref-format 		"${APPLEDOC_CROSSREF_FORMAT}"} \
${APPLEDOC_EXIT_THRESHOLD:+				--exit-threshold 		"${APPLEDOC_EXIT_THRESHOLD}"} \
${APPLEDOC_PREPROCESS_HEADERDOC:+ 		$(OptionPrefixFor $APPLEDOC_PREPROCESS_HEADERDOC)-preprocess-headerdoc} \
\
${APPLEDOC_WARN_MISSING_OUTPUT_PATH:+ 	$(OptionPrefixFor $APPLEDOC_WARN_MISSING_OUTPUT_PATH)-warn-missing-output-path} \
${APPLEDOC_WARN_MISSING_COMPANY_ID:+ 	$(OptionPrefixFor $APPLEDOC_WARN_MISSING_COMPANY_ID)-warn-missing-company-id} \
${APPLEDOC_WARN_UNDOCUMENTED_OBJECT:+ 	$(OptionPrefixFor $APPLEDOC_WARN_UNDOCUMENTED_OBJECT)-warn-undocumented-object} \
${APPLEDOC_WARN_UNDOCUMENTED_MEMBER:+ 	$(OptionPrefixFor $APPLEDOC_WARN_UNDOCUMENTED_MEMBER)-warn-undocumented-member} \
${APPLEDOC_WARN_EMPTY_DESCRIPTION:+ 	$(OptionPrefixFor $APPLEDOC_WARN_EMPTY_DESCRIPTION)-warn-empty-description} \
${APPLEDOC_WARN_UNKNOWN_DIRECTIVE:+ 	$(OptionPrefixFor $APPLEDOC_WARN_UNKNOWN_DIRECTIVE)-warn-unknown-directive} \
${APPLEDOC_WARN_INVALID_CROSSREF:+ 		$(OptionPrefixFor $APPLEDOC_WARN_INVALID_CROSSREF)-warn-invalid-crossref} \
${APPLEDOC_WARN_MISSING_ARG:+ 			$(OptionPrefixFor $APPLEDOC_WARN_MISSING_ARG)-warn-missing-arg} \
\
${APPLEDOC_DOCSET_BUNDLE_ID:+			--docset-bundle-id 			"${APPLEDOC_DOCSET_BUNDLE_ID}"} \
${APPLEDOC_DOCSET_BUNDLE_NAME:+			--docset-bundle-name 		"${APPLEDOC_DOCSET_BUNDLE_NAME}"} \
${APPLEDOC_DOCSET_DESC:+				--docset-desc 				"${APPLEDOC_DOCSET_DESC}"} \
${APPLEDOC_DOCSET_COPYRIGHT:+			--docset-copyright 			"${APPLEDOC_DOCSET_COPYRIGHT}"} \
${APPLEDOC_DOCSET_FEED_NAME:+			--docset-feed-name 			"${APPLEDOC_DOCSET_FEED_NAME}"} \
${APPLEDOC_DOCSET_FEED_URL:+			--docset-feed-url 			"${APPLEDOC_DOCSET_FEED_URL}"} \
${APPLEDOC_DOCSET_PACKAGE_URL:+			--docset-package-url 		"${APPLEDOC_DOCSET_PACKAGE_URL}"} \
${APPLEDOC_DOCSET_FALLBACK_URL:+		--docset-fallback-url 		"${APPLEDOC_DOCSET_FALLBACK_URL}"} \
${APPLEDOC_DOCSET_PUBLISHER_ID:+		--docset-publisher-id 		"${APPLEDOC_DOCSET_PUBLISHER_ID}"} \
${APPLEDOC_DOCSET_PUBLISHER_NAME:+		--docset-publisher-name 	"${APPLEDOC_DOCSET_PUBLISHER_NAME}"} \
${APPLEDOC_DOCSET_MIN_XCODE_VERSION:+	--docset-min-xcode-version 	"${APPLEDOC_DOCSET_MIN_XCODE_VERSION}"} \
${APPLEDOC_DOCSET_PLATFORM_FAMILY:+		--docset-platform-family 	"${APPLEDOC_DOCSET_PLATFORM_FAMILY}"} \
${APPLEDOC_DOCSET_CERT_ISSUER:+			--docset-cert-issuer 		"${APPLEDOC_DOCSET_CERT_ISSUER}"} \
${APPLEDOC_DOCSET_CERT_SIGNER:+			--docset-cert-signer 		"${APPLEDOC_DOCSET_CERT_SIGNER}"} \
${APPLEDOC_DOCSET_BUNDLE_FILENAME:+		--docset-bundle-filename 	"${APPLEDOC_DOCSET_BUNDLE_FILENAME}"} \
${APPLEDOC_DOCSET_ATOM_FILENAME:+		--docset-atom-filename 		"${APPLEDOC_DOCSET_ATOM_FILENAME}"} \
${APPLEDOC_DOCSET_PACKAGE_FILENAME:+	--docset-package-filename 	"${APPLEDOC_DOCSET_PACKAGE_FILENAME}"} \
\
${APPLEDOC_LOGFORMAT:+					--logformat 				"${APPLEDOC_LOGFORMAT}"} \
${APPLEDOC_VERBOSE:+					--verbose 					"${APPLEDOC_VERBOSE}"} \
${APPLEDOC_VERSION:+					--version} \
${APPLEDOC_HELP:+						--help} \
\
${APPLEDOC_SOURCE_DIRS:+				${APPLEDOC_SOURCE_DIRS[@]}}
