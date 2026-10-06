#!/bin/sh

set -eu

# GitHub supplies omitted inputs as empty strings. Leave optional lists unset
# so the CLI does not submit an empty layer ARN or architecture to AWS.
[ -n "${INPUT_SOURCE:-}" ] || unset INPUT_SOURCE
[ -n "${INPUT_ENVIRONMENT:-}" ] || unset INPUT_ENVIRONMENT
[ -n "${INPUT_LAYERS:-}" ] || unset INPUT_LAYERS
[ -n "${INPUT_SUBNETS:-}" ] || unset INPUT_SUBNETS
[ -n "${INPUT_SECURITYGROUPS:-}" ] || unset INPUT_SECURITYGROUPS
[ -n "${INPUT_SECURITY_GROUPS:-}" ] || unset INPUT_SECURITY_GROUPS
[ -n "${INPUT_ARCHITECTURES:-}" ] || unset INPUT_ARCHITECTURES

sh -c "/bin/drone-lambda $*"
