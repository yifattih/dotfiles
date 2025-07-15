-- Author: Yifattih
-- ===========================================================================
-- VIM TMUX NAVIGATOR
-- ===========================================================================

return {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
}
