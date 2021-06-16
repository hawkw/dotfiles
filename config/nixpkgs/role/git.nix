{ config, pkgs, lib, ... }:

let cfg = config.programs.eliza.git;
in with lib; {
  options = {
    programs.eliza.git = {
      enable = mkEnableOption "custom git configs";
      user = {
        name = mkOption {
          type = with types; uniq string;
          description = "Git user name";
        };
        email = mkOption {
          type = with types; uniq string;
          description = "Git user email";
        };
        privateConfig = mkOption {
          type = with types; uniq path;
          default = ./git.private.nix;
          description = "path to private local config";
          example = ./git.config.nix;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      # GitHub CLI tool
      gh = {
        enable = true;
        # use ssh whenever possible
        gitProtocol = "ssh";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };

      git = {
        enable = true;
        userName = cfg.user.name;
        userEmail = cfg.user.email;

        # aliases
        aliases = {
          rb = "rebase";
          rbct = "rebase --continue";
          # sign the last commit
          sign = "commit --amend --reuse-message=HEAD -sS";
          uncommit = "reset --hard HEAD";
          ls = ''
            log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate'';
          ll = ''
            log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat'';
          lt = "log --graph --oneline --decorate --all";
          st = "status --short --branch";
          stu = "status -uno";
          co = "checkout";
          ci = "commit";
          pr =
            "!pr() { git fetch origin pull/$1/head:pr-$1; git checkout pr-$1; }; pr";
          lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
          lola =
            "log --graph --decorate --pretty=oneline --abbrev-commit --all";
          please = "push --force-with-lease";
          commend = "commit --amend --no-edit";
          squash = "merge --squash";
          # Get the current branch name (not so useful in itself, but used in
          # other aliases)
          branch-name = "!git rev-parse --abbrev-ref HEAD";
          # Push the current branch to the remote "origin", and set it to track
          # the upstream branch
          publish = "!git push -u origin $(git branch-name)";
          # Delete the remote version of the current branch
          unpublish = "!git push origin :$(git branch-name)";
        };

        # extra git config
        extraConfig = {
          # use the default pull configuration, but stop whinging about it.
          pull.rebase = false;
          # Assembly-style commit message comments (`;` as the comment delimiter).
          # Why use `;`?
          # - The default character, `#`, conflicts with both Markdown headings
          #   and with GitHub issue links beginning a line (which I need to be
          #   able to use in commit messages).
          # - `*` conflicts with Markdown lists
          # - Git only supports a single character comment delimiter, so C-style
          #   line comments (`//`) are out...
          # - I can't think of any compelling reason to begin a line with `;`...
          core.commentchar = ";";
        };
        # If there is a file called `.git.private.nix` that defines an attribute
        # "key", sign commits with that key.
        signing = let
          path = cfg.user.privateConfig;
          exists = with builtins;
            (traceIf false
              "warning: git private config path ${path} does not exist"
              (pathExists path));
        in if exists then {
          key = with import path; key;
          signByDefault = true;
        } else
          { };
      };
    };
  };
}
