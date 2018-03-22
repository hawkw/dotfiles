
# Print Rust version number
prompt_rustup_version() {
  local rust_version
  local rustup_string
  rustup_string=$(rustup show 2>&1)

  # check if we're in the system default rust environment
  if [[ "$rustup_string" == *"(directory override for"* ]]; then
    # extract the rust version from the result of `rustup show`
    rust_version=$(echo "$rustup_string" | grep -oe "^rustc\s*[^ ]*" | grep -o '[0-9.a-z\\\-]*$')

    if [[ -n "$rust_version" ]]; then
      echo "$(print_icon "RUST_ICON")$rust_version"
    fi

  fi
}

# Kubernetes Current Context
prompt_my_kubecontext() {
  local kube_version="$(kubectl version --client 2>/dev/null)"

  if [[ -n "$kube_version" ]]; then
    # Get the current Kubernetes config context's namespaece
    local k8s_namespace=$(kubectl config get-contexts --no-headers | grep '*' | awk '{print $5}')
    # Get the current Kuberenetes context
    local k8s_context=$(kubectl config current-context)

    if [[ -z "$k8s_namespace" ]]; then
      k8s_namespace="default"
    fi
    if [[ "$k8s_context" == "${POWERLEVEL9K_CUSTOM_KUBECONTEXT_DEFAULT_CONTEXT}" ]]; then
            echo "$k8s_namespace $(print_icon "KUBERNETES_ICON")"
    else
        echo "$k8s_context/$k8s_namespace $(print_icon "KUBERNETES_ICON")"
    fi
  fi
}

POWERLEVEL9K_MODE='nerdfont-fontconfig'

POWERLEVEL9K_COLOR_SCHEME='dark'

POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_HOME_SUB_ICON="$(print_icon 'HOME_ICON')"
POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') "
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_DELIMITER=".."
POWERLEVEL9K_HOME_FOLDER_ABBREVIATION=""
POWERLEVEL9K_DIR_HOME_BACKGROUND="008"
POWERLEVEL9K_DIR_HOME_FOREGROUND="000"
POWERLEVEL9K_DIR_HOME_VISUAL_IDENTIFIER_COLOR="000"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="008"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="000"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_VISUAL_IDENTIFIER_COLOR="000"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="008"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="000"
POWERLEVEL9K_DIR_DEFAULT_VISUAL_IDENTIFIER_COLOR="000"

POWERLEVEL9K_DIR_DEFAULT_SUBFOLDER_BACKGROUND="008"
POWERLEVEL9K_DIR_DEFAULT_SUBFOLDER_FOREGROUND="000"
POWERLEVEL9K_DIR_DEFAULT_SUBFOLDER_VISUAL_IDENTIFIER_COLOR="000"

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="255"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="255"

POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="012"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="008"

POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'

POWERLEVEL9K_CONTEXT_BACKGROUND="008"
POWERLEVEL9K_CONTEXT_FOREGROUND="012"

POWERLEVEL9K_TIME_BACKGROUND="004"
POWERLEVEL9K_TIME_FOREGROUND="007"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="004"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="007"
# Output time, date, and a symbol from the "Awesome Powerline Font" set
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"

POWERLEVEL9K_HISTORY_FOREGROUND="007"
POWERLEVEL9K_HISTORY_BACKGROUND="004"

POWERLEVEL9K_STATUS_OK_BACKGROUND="012"
POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_COLOR="008"
POWERLEVEL9K_STATUS_OK_FOREGROUND="008"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="255"
POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_COLOR="255"

POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="012"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="008"

POWERLEVEL9K_CUSTOM_RUSTUP_VERSION="prompt_rustup_version"
POWERLEVEL9K_CUSTOM_RUSTUP_VERSION_BACKGROUND="216"

POWERLEVEL9K_CUSTOM_KUBECONTEXT="prompt_my_kubecontext"
POWERLEVEL9K_CUSTOM_KUBECONTEXT_DEFAULT_CONTEXT="gke_buoyant-hosted_us-central1-b_hosted-n1-standard-32"
POWERLEVEL9K_CUSTOM_KUBECONTEXT_BACKGROUND="008"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context
    root_indicator
    dir
    dir_writable
    vcs
    )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    custom_rustup_version
    aws
    custom_kubecontext
    # kubecontext
    virtualenv
    rbenv
    rvm
    docker_machine
    background_jobs
    status
    command_execution_time
    )
