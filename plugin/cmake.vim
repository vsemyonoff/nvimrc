let g:cmake_build_dir_location = "build"
let g:cmake_default_config = "debug"
let g:cmake_root_markers = [ ".git", ".project", "build" ]
let g:cmake_link_compile_commands = 1
let g:cmake_native_build_options = [ "-j8" ]

let g:cmake_jump_on_error = 0
augroup cmake
    autocmd!
    autocmd User CMakeBuildFailed CMakeClose|:cfirst
augroup END
