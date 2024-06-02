#!/bin/bash
bru_args=''
echo "::notice INPUT_PATH='${INPUT_PATH}'"
echo "::notice INPUT_FILENAME='${INPUT_FILENAME}'"
echo "::notice INPUT_RECURSIVE='${INPUT_RECURSIVE}'"
echo "::notice INPUT_ENV='${INPUT_ENV}'"
echo "::notice INPUT_ENVVARS='${INPUT_ENVVARS}'"
echo "::notice INPUT_OUTPUT='${INPUT_OUTPUT}'"
echo "::notice INPUT_OUTPUTFORMAT='${INPUT_OUTPUTFORMAT}'"
echo "::notice INPUT_INSECURE='${INPUT_INSECURE}'"
echo "::notice INPUT_TESTSONLY='${INPUT_TESTSONLY}'"
echo "::notice INPUT_BAIL='${INPUT_BAIL}'"

# Parse input parameters
# Change to provided working directory
if [ -n "${INPUT_PATH}" ]; then
  cd "${INPUT_PATH}"
fi
if [ -n "${INPUT_FILENAME}" ]; then
  bru_args="${INPUT_FILENAME}"
fi

if [ -n "${INPUT_RECURSIVE}" ]; then
  bru_args="${bru_args} -r"
fi

if [ -n "${INPUT_ENV}" ]; then
  bru_args="${bru_args} --env ${INPUT_ENV}"
fi

if [ -n "${INPUT_OUTPUT}" ]; then
  bru_args="${bru_args} --output ${INPUT_OUTPUT}"
fi

if [ -n "${INPUT_OUTPUTFORMAT}" ]; then
  bru_args="${bru_args} --format ${INPUT_OUTPUTFORMAT}"
fi

if [ -n "${INPUT_INSECURE}" ]; then
  bru_args="${bru_args} --insecure"
fi

if [ -n "${INPUT_TESTSONLY}" ]; then
  bru_args="${bru_args} --tests-only"
fi

if [ -n "${INPUT_BAIL}" ]; then
  bru_args="${bru_args} --bail"
fi

# Assign --env-var key=value if provided
# Key value pairs must be separated by line breaks
while read -r env_var; do
  bru_args="${bru_args} --env-var ${env_var}"
done < <(echo -e "${INPUT_ENVVARS}")

# Write outputs to the $GITHUB_OUTPUT file
echo "success=yup" >> "$GITHUB_OUTPUT"

# Run bru cli
echo "workdir: '$(pwd)'"
echo "bru run ${bru_args}"
# bru run ${bru_args}

exit 0
