REVEAL_ARCHIVE_IN_FINDER=true

FRAMEWORK_NAME="${PROJECT_NAME}"

SIMULATOR_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework"

DEVICE_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework"

UNIVERSAL_LIBRARY_DIR="${BUILD_DIR}/${CONFIGURATION}-iphoneuniversal"

FRAMEWORK="${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework"

build_frameworks() {
    ######################
    # Build Frameworks
    ######################

    xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" PU=${PU} IS_REACT=${IS_REACT} WITH_PUSH=${WITH_PUSH} -target ${PROJECT_NAME} ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} clean build -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

    xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" PU=${PU} IS_REACT=${IS_REACT} WITH_PUSH=${WITH_PUSH} -target ${PROJECT_NAME} ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} clean build -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

    ######################
    # Create directory for universal
    ######################

    rm -rf "${UNIVERSAL_LIBRARY_DIR}"

    mkdir "${UNIVERSAL_LIBRARY_DIR}"

    mkdir "${FRAMEWORK}"


    ######################
    # Copy files Framework
    ######################

    cp -r "${DEVICE_LIBRARY_PATH}/." "${FRAMEWORK}"


    ######################
    # Make fat universal binary
    ######################

    lipo "${DEVICE_LIBRARY_PATH}/${FRAMEWORK_NAME}" "${SIMULATOR_LIBRARY_PATH}/${FRAMEWORK_NAME}" -create -output "${FRAMEWORK}/${FRAMEWORK_NAME}" | echo


    ######################
    # On Release, copy the result to desktop folder
    ######################

    if [ "${CONFIGURATION}" == "Release" ]; then
    if [ -d "${PROJECT_DIR}/$1/" ]; then
    rm -rf "${PROJECT_DIR}/$1/"
    fi
    mkdir -p "${PROJECT_DIR}/$1/"
    cp -r "${FRAMEWORK}" "${PROJECT_DIR}/$1/"
    fi


    ######################
    # If needed, open the Framework folder
    ######################

    # if [ ${REVEAL_ARCHIVE_IN_FINDER} = true ]; then
    # if [ "${CONFIGURATION}" == "Release" ]; then
    # open "${PROJECT_DIR}/$1/${FRAMEWORK_NAME}-${CONFIGURATION}-iphoneuniversal/"
    # else
    # open "${UNIVERSAL_LIBRARY_DIR}/"
    # fi
    # fi
}

GCC_PREPROCESSOR_DEFINITIONS="WITH_PUSH=true IS_REACT=false PU=false"
WITH_PUSH="${GCC_PREPROCESSOR_DEFINITIONS//*WITH_PUSH=/}"
WITH_PUSH="${WITH_PUSH// */}"
IS_REACT="${GCC_PREPROCESSOR_DEFINITIONS//*IS_REACT=/}"
IS_REACT="${IS_REACT// */}"

build_frameworks "with_push"

GCC_PREPROCESSOR_DEFINITIONS="WITH_PUSH=true IS_REACT=true PU=false"
WITH_PUSH="${GCC_PREPROCESSOR_DEFINITIONS//*WITH_PUSH=/}"
WITH_PUSH="${WITH_PUSH// */}"
IS_REACT="${GCC_PREPROCESSOR_DEFINITIONS//*IS_REACT=/}"
IS_REACT="${IS_REACT// */}"

# build_frameworks "react"

GCC_PREPROCESSOR_DEFINITIONS="WITH_PUSH=false IS_REACT=false PU=false"
WITH_PUSH="${GCC_PREPROCESSOR_DEFINITIONS//*WITH_PUSH=/}"
WITH_PUSH="${WITH_PUSH// */}"
IS_REACT="${GCC_PREPROCESSOR_DEFINITIONS//*IS_REACT=/}"
IS_REACT="${IS_REACT// */}"

build_frameworks "without_push"

GCC_PREPROCESSOR_DEFINITIONS="WITH_PUSH=true IS_REACT=false PU=true"
WITH_PUSH="${GCC_PREPROCESSOR_DEFINITIONS//*WITH_PUSH=/}"
WITH_PUSH="${WITH_PUSH// */}"
IS_REACT="${GCC_PREPROCESSOR_DEFINITIONS//*IS_REACT=/}"
IS_REACT="${IS_REACT// */}"
PU="${GCC_PREPROCESSOR_DEFINITIONS//*PU=/}"
PU="${PU// */}"

# build_frameworks "with_push_peixe"

GCC_PREPROCESSOR_DEFINITIONS="WITH_PUSH=false IS_REACT=false PU=true"
WITH_PUSH="${GCC_PREPROCESSOR_DEFINITIONS//*WITH_PUSH=/}"
WITH_PUSH="${WITH_PUSH// */}"
IS_REACT="${GCC_PREPROCESSOR_DEFINITIONS//*IS_REACT=/}"
IS_REACT="${IS_REACT// */}"
PU="${GCC_PREPROCESSOR_DEFINITIONS//*PU=/}"
PU="${PU// */}"

# build_frameworks "without_push_peixe"
