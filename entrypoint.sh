#!/usr/bin/env bash

export HELM_REPOSITORY_URL=${INPUT_HELM_REPOSITORY_URL}
export HELM_REPOSITORY_NAME=${INPUT_HELM_REPOSITORY_NAME}
export HELM_REPOSITORY_ALIAS=${INPUT_HELM_REPOSITORY_ALIAS}
export HELM_REPOSITORY_USER=${INPUT_HELM_REPOSITORY_USER}
export HELM_REPOSITORY_PASSWORD=${INPUT_HELM_REPOSITORY_PASSWORD}
export HELM_REPOSITORY_INSECURE=${INPUT_HELM_REPOSITORY_INSECURE}
export HELM_CHART=${INPUT_HELM_CHART}
export HELM_CHART_VERSION=${INPUT_HELM_CHART_VERSION}
export HELM_VALUES_FILE=${INPUT_HELM_VALUES_FILE}
export HELM_REPOSITORY_ADD_EXTRA_ARGS=${INPUT_HELM_REPOSITORY_ADD_EXTRA_ARGS:-""}
export HELM_REPOSITORY_UPGRADE_EXTRA_ARGS=${INPUT_HELM_REPOSITORY_UPGRADE_EXTRA_ARGS:-""}
export APP_NAME=${INPUT_APP_NAME}
export NAMESPACE=${INPUT_NAMESPACE}
export KUBECONFIG=${INPUT_KUBECONFIG}

function required() {
    if [ -z "${1}" ]; then
        echo >&2 "${2} variable is required!"
        exit 1
    fi
}

required "${HELM_REPOSITORY_URL}" "helm_repository_url"
required "${HELM_REPOSITORY_NAME}" "helm_repository_name"
required "${HELM_REPOSITORY_ALIAS}" "helm_repository_alias"
required "${HELM_REPOSITORY_USER}" "helm_repository_user"
required "${HELM_REPOSITORY_PASSWORD}" "helm_repository_password"
required "${HELM_CHART}" "helm_chart"
required "${APP_NAME}" "app_name"
required "${NAMESPACE}" "namespace"
required "${KUBECONFIG}" "kubeconfig"


if [ "${HELM_REPOSITORY_INSECURE}" ] && [ "${HELM_REPOSITORY_INSECURE}" = "true" ]; then
    HELM_REPOSITORY_ADD_EXTRA_ARGS+=" --insecure-skip-tls-verify"
    HELM_REPOSITORY_UPGRADE_EXTRA_ARGS+=" --insecure-skip-tls-verify"
fi

if [ "${HELM_VALUES_FILE}" ]; then
    HELM_REPOSITORY_UPGRADE_EXTRA_ARGS+=" -f ${HELM_VALUES_FILE}"
fi

if [ "${HELM_CHART_VERSION}" ]; then
    HELM_REPOSITORY_UPGRADE_EXTRA_ARGS+=" --version ${HELM_CHART_VERSION}"
fi

cat <<EOF > /kubeconfig.yaml
$KUBECONFIG
EOF

export KUBECONFIG="/kubeconfig.yaml"

helm repo add "${HELM_REPOSITORY_ALIAS}" "https://${HELM_REPOSITORY_URL}/repository/${HELM_REPOSITORY_NAME}" \
    --username "${HELM_REPOSITORY_USER}" \
    --password "${HELM_REPOSITORY_PASSWORD}" $HELM_REPOSITORY_ADD_EXTRA_ARGS

helm repo update

helm upgrade "${APP_NAME}"  "${HELM_REPOSITORY_ALIAS}/${HELM_CHART}" -n "${NAMESPACE}" -i $HELM_REPOSITORY_UPGRADE_EXTRA_ARGS