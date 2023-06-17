return {
  updater = {
    remote = "origin",
    channel = "stable",
    version = "v3.*",
    pin_plugins = true,
    skip_prompts = false,
    show_changelog = true,
    auto_quit = true,
    -- remotes = {
    --   ['remote_name'] = 'github_user/repo', -- GitHub user/repo shortcut,
    -- },
  },
}
