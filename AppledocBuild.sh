#!/bin/sh

#  AppledocBuild.sh
#  AppleDocTargetTest
#
#  Created by Looker Jules on 22/11/2011.
#  Copyright (c) 2011 The Interface Works. All rights reserved.

# 	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

#	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#	appledoc command line comments courtesy of $ appledoc --help # www.gentlebytes.com


# appledoc already does a great job of integrating with Xcode. AppledocBuild.sh adds to this and brings closer integration of appledoc configuration with Xcode 4 build settings. Using AppledocBuild.sh you will be able to specify custon appledoc settings based on configuration, Debug/Release etc. whilst making full use of build environment variables an shell expansions PLUS you can retrieve or compute values to pass to appledoc from other sources like <project>-Info.plist or Organization name from the .xcodeproj you're target is in.

# FULL INSTRUCTIONS: See end of file.


# Project Info.plist file based on standard Xcode <project>-Info.plist convention
PLIST_FILE="${PROJECT_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-Info.plist"

# [OPTIONS]

# PATHS

# -o, --output <path>			Output path
APPLEDOC_DEFAULT_OUTPUT=
APPLEDOC_OUTPUT=${APPLEDOC_OUTPUT=$APPLEDOC_DEFAULT_OUTPUT}

# -t, --templates <path>		Template files path
APPLEDOC_DEFAULT_TEMPLATES=
APPLEDOC_TEMPLATES=${APPLEDOC_TEMPLATES=$APPLEDOC_DEFAULT_TEMPLATES}

# --docset-install-path <path>	DocSet installation path
APPLEDOC_DEFAULT_DOCSET_INSTALL_PATH=
APPLEDOC_DOCSET_INSTALL_PATH=${APPLEDOC_DOCSET_INSTALL_PATH=$APPLEDOC_DEFAULT_DOCSET_INSTALL_PATH}

# -s, --include <path>			Include static doc(s) at path
APPLEDOC_DEFAULT_INCLUDE=
APPLEDOC_INCLUDE=(${APPLEDOC_INCLUDE=$APPLEDOC_DEFAULT_INCLUDE})						# Array

# -i, --ignore <path>			Ignore given path
APPLEDOC_DEFAULT_IGNORE=
APPLEDOC_IGNORE=(${APPLEDOC_IGNORE=$APPLEDOC_DEFAULT_IGNORE})							# Array

# -x, --exclude-output <path>	Exclude given path from output
APPLEDOC_DEFAULT_EXCLUDE_OUTPUT=
APPLEDOC_EXCLUDE_OUTPUT=(${APPLEDOC_EXCLUDE_OUTPUT=$APPLEDOC_DEFAULT_EXCLUDE_OUTPUT})	# Array

# --index-desc <path>			File including main index description
APPLEDOC_DEFAULT_INDEX_DESC=
APPLEDOC_INDEX_DESC=${APPLEDOC_INDEX_DESC=$APPLEDOC_DEFAULT_INDEX_DESC}


# PROJECT INFO

# -p, --project-name <string>		Project name
APPLEDOC_DEFAULT_PROJECT_NAME=
APPLEDOC_PROJECT_NAME=${APPLEDOC_PROJECT_NAME=$APPLEDOC_DEFAULT_PROJECT_NAME}

# -v, --project-version <string>	Project version
APPLEDOC_DEFAULT_PROJECT_VERSION=
APPLEDOC_PROJECT_VERSION=${APPLEDOC_PROJECT_VERSION=$APPLEDOC_DEFAULT_PROJECT_VERSION}

# -c, --project-company <string>	Project company
APPLEDOC_DEFAULT_PROJECT_COMPANY=
APPLEDOC_PROJECT_COMPANY=${APPLEDOC_PROJECT_COMPANY=$APPLEDOC_DEFAULT_PROJECT_COMPANY}

# --company-id <string>				Company UTI (i.e. reverse DNS name)
APPLEDOC_DEFAULT_COMPANY_ID=
APPLEDOC_COMPANY_ID=${APPLEDOC_COMPANY_ID=$APPLEDOC_DEFAULT_COMPANY_ID}


# OUTPUT GENERATION

# -h, --create-html					[b] Create HTML
APPLEDOC_DEFAULT_CREATE_HTML=
APPLEDOC_CREATE_HTML=${APPLEDOC_CREATE_HTML=$APPLEDOC_DEFAULT_CREATE_HTML}

# -d, --create-docset				[b] Create documentation set
APPLEDOC_DEFAULT_CREATE_DOCSET=
APPLEDOC_CREATE_DOCSET=${APPLEDOC_CREATE_DOCSET=$APPLEDOC_DEFAULT_CREATE_DOCSET}

# -n, --install-docset				[b] Install documentation set to Xcode
APPLEDOC_DEFAULT_INSTALL_DOCSET=
APPLEDOC_INSTALL_DOCSET=${APPLEDOC_INSTALL_DOCSET=$APPLEDOC_DEFAULT_INSTALL_DOCSET}

# -u, --publish-docset				[b] Prepare DocSet for publishing
APPLEDOC_DEFAULT_PUBLISH_DOCSET=
APPLEDOC_PUBLISH_DOCSET=${APPLEDOC_PUBLISH_DOCSET=$APPLEDOC_DEFAULT_PUBLISH_DOCSET}

# --clean-output					[b] Remove contents of output path before starting !!CAUTION!!
APPLEDOC_DEFAULT_CLEAN_OUTPUT=
APPLEDOC_CLEAN_OUTPUT=${APPLEDOC_CLEAN_OUTPUT=$APPLEDOC_DEFAULT_CLEAN_OUTPUT}


# OPTIONS

# --keep-intermediate-files           [b] Keep intermediate files in output path
APPLEDOC_DEFAULT_KEEP_INTERMEDIATE_FILES=
APPLEDOC_KEEP_INTERMEDIATE_FILES=${APPLEDOC_KEEP_INTERMEDIATE_FILES=$APPLEDOC_DEFAULT_KEEP_INTERMEDIATE_FILES}

# --keep-undocumented-objects         [b] Keep undocumented objects
APPLEDOC_DEFAULT_KEEP_UNDOCUMENTED_OBJECTS=
APPLEDOC_KEEP_UNDOCUMENTED_OBJECTS=${APPLEDOC_KEEP_UNDOCUMENTED-OBJECTS=$APPLEDOC_DEFAULT_KEEP_UNDOCUMENTED-OBJECTS}

# --keep-undocumented-members         [b] Keep undocumented members
APPLEDOC_DEFAULT_KEEP_UNDOCUMENTED_MEMBERS=
APPLEDOC_KEEP_UNDOCUMENTED_MEMBERS=${APPLEDOC_KEEP_UNDOCUMENTED_MEMBERS=$APPLEDOC_DEFAULT_KEEP_UNDOCUMENTED_MEMBERS}

# --search-undocumented-doc           [b] Search undocumented members documentation
APPLEDOC_DEFAULT_SEARCH_UNDOCUMENTED_DOC=
APPLEDOC_SEARCH_UNDOCUMENTED_DOC=${APPLEDOC_SEARCH_UNDOCUMENTED_DOC=$APPLEDOC_DEFAULT_SEARCH_UNDOCUMENTED_DOC}

# --repeat-first-par                  [b] Repeat first paragraph in member documentation
APPLEDOC_DEFAULT_REPEAT_FIRST_PAR=
APPLEDOC_REPEAT_FIRST_PAR=${APPLEDOC_REPEAT_FIRST_PAR=$APPLEDOC_DEFAULT_REPEAT_FIRST_PAR}

# --merge-categories                  [b] Merge categories to classes
APPLEDOC_DEFAULT_MERGE_CATEGORIES=
APPLEDOC_MERGE_CATEGORIES=${APPLEDOC_MERGE_CATEGORIES=$APPLEDOC_DEFAULT_MERGE_CATEGORIES}

# --keep-merged-sections              [b] Keep merged categories sections
APPLEDOC_DEFAULT_KEEP_MERGED_SECTIONS=
APPLEDOC_KEEP_MERGED_SECTIONS=${APPLEDOC_KEEP_MERGED_SECTIONS=$APPLEDOC_DEFAULT_KEEP_MERGED_SECTIONS}

# --prefix-merged-sections            [b] Prefix merged sections with category name
APPLEDOC_DEFAULT_PREFIX_MERGED_SECTIONS=
APPLEDOC_PREFIX_MERGED_SECTIONS=${APPLEDOC_PREFIX_MERGED_SECTIONS=$APPLEDOC_DEFAULT_PREFIX_MERGED_SECTIONS}

# --explicit-crossref                 [b] Shortcut for explicit default cross ref template
APPLEDOC_DEFAULT_EXPLICIT_CROSSREF=
APPLEDOC_EXPLICIT_CROSSREF=${APPLEDOC_EXPLICIT_CROSSREF=$APPLEDOC_DEFAULT_EXPLICIT_CROSSREF}

# --crossref-format <string>          Cross reference template regex
APPLEDOC_DEFAULT_CROSSREF_FORMAT=
APPLEDOC_CROSSREF_FORMAT=${APPLEDOC_CROSSREF_FORMAT=$APPLEDOC_DEFAULT_CROSSREF_FORMAT}

# --exit-threshold <number>           Exit code threshold below which 0 is returned
APPLEDOC_DEFAULT_EXIT_THRESHOLD=
APPLEDOC_EXIT_THRESHOLD=${APPLEDOC_EXIT_THRESHOLD=$APPLEDOC_DEFAULT_EXIT_THRESHOLD}

# --preprocess-headerdoc              [b] 
APPLEDOC_DEFAULT_PREPROCESS_HEADERDOC=
APPLEDOC_PREPROCESS_HEADERDOC=${APPLEDOC_PREPROCESS_HEADERDOC=$APPLEDOC_DEFAULT_PREPROCESS_HEADERDOC}

# WARNINGS

# --warn-missing-output-path          [b] Warn if output path is not given
APPLEDOC_DEFAULT_WARN_MISSING_OUTPUT_PATH=
APPLEDOC_WARN_MISSING_OUTPUT_PATH=${APPLEDOC_WARN_MISSING_OUTPUT_PATH=$APPLEDOC_DEFAULT_WARN_MISSING_OUTPUT_PATH}

# --warn-missing-company-id           [b] Warn if company ID is not given
APPLEDOC_DEFAULT_WARN_MISSING_COMPANY_ID=
APPLEDOC_WARN_MISSING_COMPANY_ID=${APPLEDOC_WARN_MISSING_COMPANY_ID=$APPLEDOC_DEFAULT_WARN_MISSING_COMPANY_ID}

# --warn-undocumented-object          [b] Warn on undocumented object
APPLEDOC_DEFAULT_WARN_UNDOCUMENTED_OBJECT=
APPLEDOC_WARN_UNDOCUMENTED_OBJECT=${APPLEDOC_WARN_UNDOCUMENTED_OBJECT=$APPLEDOC_DEFAULT_WARN_UNDOCUMENTED_OBJECT}

# --warn-undocumented-member          [b] Warn on undocumented member
APPLEDOC_DEFAULT_WARN_UNDOCUMENTED_MEMBER=
APPLEDOC_WARN_UNDOCUMENTED_MEMBER=${APPLEDOC_WARN_UNDOCUMENTED_MEMBER=$APPLEDOC_DEFAULT_WARN_UNDOCUMENTED_MEMBER}

# --warn-empty-description            [b] Warn on empty description block
APPLEDOC_DEFAULT_WARN_EMPTY_DESCRIPTION=
APPLEDOC_WARN_EMPTY_DESCRIPTION=${APPLEDOC_WARN_EMPTY_DESCRIPTION=$APPLEDOC_DEFAULT_WARN_EMPTY_DESCRIPTION}

# --warn-unknown-directive            [b] Warn on unknown directive or format
APPLEDOC_DEFAULT_WARN_UNKNOWN_DIRECTIVE=
APPLEDOC_WARN_UNKNOWN_DIRECTIVE=${APPLEDOC_WARN_UNKNOWN_DIRECTIVE=$APPLEDOC_DEFAULT_WARN_UNKNOWN_DIRECTIVE}

# --warn-invalid-crossref             [b] Warn on invalid cross reference
APPLEDOC_DEFAULT_WARN_INVALID_CROSSREF=
APPLEDOC_WARN_INVALID_CROSSREF=${APPLEDOC_WARN_INVALID_CROSSREF=$APPLEDOC_DEFAULT_WARN_INVALID_CROSSREF}

# --warn-missing-arg                  [b] Warn on missing method argument documentation
APPLEDOC_DEFAULT_WARN_MISSING_ARG=
APPLEDOC_WARN_MISSING_ARG=${APPLEDOC_WARN_MISSING_ARG=$APPLEDOC_DEFAULT_WARN_MISSING_ARG}


# DOCUMENTATION SET INFO

# --docset-bundle-id <string>         [*] DocSet bundle identifier
APPLEDOC_DEFAULT_DOCSET_BUNDLE_ID=
APPLEDOC_DOCSET_BUNDLE_ID=${APPLEDOC_DOCSET_BUNDLE_ID=$APPLEDOC_DEFAULT_DOCSET_BUNDLE_ID}

# --docset-bundle-name <string>       [*] DocSet bundle name
APPLEDOC_DEFAULT_DOCSET_BUNDLE_NAME=
APPLEDOC_DOCSET_BUNDLE_NAME=${APPLEDOC_DOCSET_BUNDLE_NAME=$APPLEDOC_DEFAULT_DOCSET_BUNDLE_NAME}

# --docset-desc <string>              [*] DocSet description
APPLEDOC_DEFAULT_DOCSET_DESC=
APPLEDOC_DOCSET_DESC=${APPLEDOC_DOCSET_DESC=$APPLEDOC_DEFAULT_DOCSET_DESC}

# --docset-copyright <string>         [*] DocSet copyright message
APPLEDOC_DEFAULT_DOCSET_COPYRIGHT=
APPLEDOC_DOCSET_COPYRIGHT=${APPLEDOC_DOCSET_COPYRIGHT=$APPLEDOC_DEFAULT_DOCSET_COPYRIGHT}

# --docset-feed-name <string>         [*] DocSet feed name
APPLEDOC_DEFAULT_DOCSET_FEED_NAME=
APPLEDOC_DOCSET_FEED_NAME=${APPLEDOC_DOCSET_FEED_NAME=$APPLEDOC_DEFAULT_DOCSET_FEED_NAME}

# --docset-feed-url <string>          [*] DocSet feed URL
APPLEDOC_DEFAULT_DOCSET_FEED_URL=
APPLEDOC_DOCSET_FEED_URL=${APPLEDOC_DOCSET_FEED_URL=$APPLEDOC_DEFAULT_DOCSET_FEED_URL}

# --docset-package-url <string>       [*] DocSet package (.xar) URL
APPLEDOC_DEFAULT_DOCSET_PACKAGE_URL=
APPLEDOC_DOCSET_PACKAGE_URL=${APPLEDOC_DOCSET_PACKAGE_URL=$APPLEDOC_DEFAULT_DOCSET_PACKAGE_URL}

# --docset-fallback-url <string>      [*] DocSet fallback URL
APPLEDOC_DEFAULT_DOCSET_FALLBACK_URL=
APPLEDOC_DOCSET_FALLBACK_URL=${APPLEDOC_DOCSET_FALLBACK_URL=$APPLEDOC_DEFAULT_DOCSET_FALLBACK_URL}

# --docset-publisher-id <string>      [*] DocSet publisher identifier
APPLEDOC_DEFAULT_DOCSET_PUBLISHER_ID=
APPLEDOC_DOCSET_PUBLISHER_ID=${APPLEDOC_DOCSET_PUBLISHER_ID=$APPLEDOC_DEFAULT_DOCSET_PUBLISHER_ID}

# --docset-publisher-name <string>    [*] DocSet publisher name
APPLEDOC_DEFAULT_DOCSET_PUBLISHER_NAME=
APPLEDOC_DOCSET_PUBLISHER_NAME=${APPLEDOC_DOCSET_PUBLISHER_NAME=$APPLEDOC_DEFAULT_DOCSET_PUBLISHER_NAME}

# --docset-min-xcode-version <string> [*] DocSet min. Xcode version
APPLEDOC_DEFAULT_DOCSET_MIN_XCODE_VERSION=
APPLEDOC_DOCSET_MIN_XCODE_VERSION=${APPLEDOC_DOCSET_MIN_XCODE_VERSION=$APPLEDOC_DEFAULT_DOCSET_MIN_XCODE_VERSION}

# --docset-platform-family <string>   [*] DocSet platform familiy
APPLEDOC_DEFAULT_DOCSET_PLATFORM_FAMILY=
APPLEDOC_DOCSET_PLATFORM_FAMILY=${APPLEDOC_DOCSET_PLATFORM_FAMILY=$APPLEDOC_DEFAULT_DOCSET_PLATFORM_FAMILY}

# --docset-cert-issuer <string>       [*] DocSet certificate issuer
APPLEDOC_DEFAULT_DOCSET_CERT_ISSUER=
APPLEDOC_DOCSET_CERT_ISSUER=${APPLEDOC_DOCSET_CERT_ISSUER=$APPLEDOC_DEFAULT_DOCSET_CERT_ISSUER}

# --docset-cert-signer <string>       [*] DocSet certificate signer
APPLEDOC_DEFAULT_DOCSET_CERT_SIGNER=
APPLEDOC_DOCSET_CERT_SIGNER=${APPLEDOC_DOCSET_CERT_SIGNER=$APPLEDOC_DEFAULT_DOCSET_CERT_SIGNER}

# --docset-bundle-filename <string>   [*] DocSet bundle filename
APPLEDOC_DEFAULT_DOCSET_BUNDLE_FILENAME=
APPLEDOC_DOCSET_BUNDLE_FILENAME=${APPLEDOC_DOCSET_BUNDLE_FILENAME=$APPLEDOC_DEFAULT_DOCSET_BUNDLE_FILENAME}

# --docset-atom-filename <string>     [*] DocSet atom feed filename
APPLEDOC_DEFAULT_DOCSET_ATOM_FILENAME=
APPLEDOC_DOCSET_ATOM_FILENAME=${APPLEDOC_DOCSET_ATOM_FILENAME=$APPLEDOC_DEFAULT_DOCSET_ATOM_FILENAME}

# --docset-package-filename <string>  [*] DocSet package (.xar) filename
APPLEDOC_DEFAULT_DOCSET_PACKAGE_FILENAME=
APPLEDOC_DOCSET_PACKAGE_FILENAME=${APPLEDOC_DOCSET_PACKAGE_FILENAME=$APPLEDOC_DEFAULT_DOCSET_PACKAGE_FILENAME}


# MISCELLANEOUS

# --logformat <number>                Log format [0-3]
APPLEDOC_DEFAULT_LOGFORMAT=
APPLEDOC_LOGFORMAT=${APPLEDOC_LOGFORMAT=$APPLEDOC_DEFAULT_LOGFORMAT}

# --verbose <value>                   Log verbosity level [0-6,xcode]
APPLEDOC_DEFAULT_VERBOSE=
APPLEDOC_VERBOSE=${APPLEDOC_VERBOSE=$APPLEDOC_DEFAULT_VERBOSE}

# --version                           Display version and exit
APPLEDOC_DEFAULT_VERSION=
APPLEDOC_VERSION=${APPLEDOC_VERSION=$APPLEDOC_DEFAULT_VERSION}

# --help                              Display this help and exit
APPLEDOC_DEFAULT_HELP=
APPLEDOC_HELP=${APPLEDOC_HELP=$APPLEDOC_DEFAULT_HELP}

# [b] boolean parameter, uses no value, use --no- prefix to negate.

# [*] indicates parameters accepting placeholder strings:
# - %PROJECT replaced with --project-name
# - %PROJECTID replaced with normalized --project-name
# - %VERSION replaced with --project-version
# - %VERSIONID replaced with normalized --project-version
# - %COMPANY replaced with --project-company
# - %COMPANYID replaced with --company-id
# - %YEAR replaced with current year (format yyyy)
# - %UPDATEDATE replaced with current date (format yyyy-MM-dd)
# - %DOCSETBUNDLEFILENAME replaced with --docset-bundle-filename
# - %DOCSETATOMFILENAME replaced with --docset-atom-filename
# - %DOCSETPACKAGEFILENAME replaced with --docset-package-filename


# <paths to source dirs or files>

APPLEDOC_DEFAULT_SOURCE_DIRS=
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


# OVERVIEW

# AppledocBuild.sh assists integration of appledoc into the Xcode 4 build process

# The script executes appledoc passing options specified by user-defined Xcode build settings

# User-defined build setting names are of the form APPLEDOC_<OPTION_NAME>
# All build settings are listed in the accompanying AppledocNil.xcconfig
# Specifying AppledocNil.xcconfig as the Configuration for a Target adds the build settings with nil values to the Build Settings of the Target
# Optionally, copy or edit AppledocNil.xcconfig as required to make suitable .xcconfig with desired values for your project

# AppledocBuild.sh contains default environment variables using the form APPLEDOC_DEFAULT_<OPTION_NAME>
# The default value is applied to the corresponding build setting when the build setting is unset or has a null value
# The default is NOT applied when a value is defined for the corresponding setting in the Target's Build Settings or an applied .xcconfig file
#
# To define a default setting simply assign a value to a APPLEDOC_DEFAULT_<*> variable above eg.
#        APPLEDOC_DEFAULT_DOCSET_COPYRIGHT="My default copyright. All rights reserved."
#
# Defaults can also be computed. The example shows retrieval of the copyright message from the <project>-Info.plist. 
#        APPLEDOC_DEFAULT_DOCSET_COPYRIGHT=$(/usr/libexec/PlistBuddy -c "Print NSHumanReadableCopyright" "${PLIST_FILE}" 2>&1)
#
# Add a little more voo-nix and you can  get the Organization name from the Xcode 4 Project
#        XCODE_PROJECT_ORGANIZATION=$(grep ORGANIZATIONNAME ${PROJECT_DIR}/${PROJECT_NAME}.xcodeproj/project.pbxproj)
#        PROJECT_ORGANIZATION=${XCODE_PROJECT_ORGANIZATION#*\"}
#        PROJECT_ORGANIZATION=${PROJECT_ORGANIZATION%\"*}
#        APPLEDOC_DEFAULT_PROJECT_COMPANY=${PROJECT_ORGANIZATION:-"No Organization Value"}


# USAGE

# Prerequisites: appledoc installed in location on search PATH.

# Assumptions:   Familiarity with appledoc
#                Xcode 4 build system knowledge
#                appledoc 2.0.4 build 703 or later.
#                PlistBuddy installed at /usr/libexec/

# AppledocBuild.sh can be used as part of an External Build System or as a Build Phase Run Script

# External Build System - OS X
#    Add an External Build System Target (Doc) to your Project
#    Select your Project in the Project navigator
#    Select the Doc target
#    Choose the |Info| tab for Doc target
#    Expand External Build Tool Configuration group
#    Configure values:
#
#        Build=/bin/sh
#        Arguments=<PATH_TO>/AppledocBuild.sh
#        Directory=
#        Pass build settings in environment=CHECKED
#
#    NOTE - Expansions similar to $(PROJECT_DIR)/AppledocBuild.sh are useful for Arguments
#
#    Choose the |Build Settings| tab for Doc target
##   Click the (Add Build Setting) button
##   Choose {User-Defined Setting} option
##   Replace New_Setting placeholder with APPLEDOC_PROJECT_NAME
##   Enter "PROJECT NAME" in adjacent cell in Doc target column
##
##   Enter the following Build Settings:
##
##       APPLEDOC_PROJECT_NAME                 PROJECT NAME              # NOTE - Already entered in example above, included for completeness
##       APPLEDOC_PROJECT_COMPANY              PROJECT COMPANY
##       APPLEDOC_COMPANY_ID                   com.mycompany
##       APPLEDOC_OUTPUT                       $CONFIGURATION_BUILD_DIR
##       APPLEDOC_LOGFORMAT                    xcode
##       APPLEDOC_EXIT_THRESHOLD               2
##       APPLEDOC_KEEP_UNDOCUMENTED_OBJECTS    YES
##       APPLEDOC_KEEP_UNDOCUMENTED_MEMBERS    YES
##       APPLEDOC_IGNORE                       .m $(PROJECT_NAME)Tests
##       APPLEDOC_SOURCE_DIRS                  $PROJECT_DIR
#
#    Select Scheme for the Doc Target
#    Select Product>Build
#    appledoc will build and install documentation. (Warnings will appear for undocumented objects and members)
#    Select Xcode>Preferences...|Downloads| |Documentation|. You should see the documentation installed in list

# Build Phase Run Script - OS X & iOS
#
#    Select your project in the Project navigator
#    Select an existing application target (App)
#    Choose the |Build Phases| tab
#    Click the (Add Build Phase) button
#    Choose {Add Run Script} option
#    Configure values for Run Script:
#
#        Shell=/bin/sh
#        Script=. <PATH_TO>/AppledocBuild.sh
#        Show environment variables in build log=CHECKED
#        Run script only on installing=UNCHECKED
#        Input Files=NONE
#        Output Files=NONE
#
#    Choose the |Build Settings| tab for App target
#    Follow instructions above denoted by ## at begining of line
#
#    Select Scheme for the App Target
#    Select Porduct>Build
#    appledoc will build and install documentation. (Warnings will appear for undocumented objects and members)
#    Select Xcode>Preferences...|Downloads| |Documentation|. You should see the documentation installed in list

# END