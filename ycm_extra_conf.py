def FlagsForFile(filename, **kwargs):
    flags = [
        '-Wall',
        '-Wextra',
        '-Werror',
        '-pedantic',
        '-I.',
    ]
    filetype = kwargs['client_data']['&filetype']
    if filetype == 'c':
        flags += [ '-xc', '-std=c11' ]
    elif filetype == 'cpp':
        flags += [ '-xc++', '-std=c++14' ]
    elif filetype == 'objc':
        flags += [ '-ObjC' ]
    else:
        flags = []
    return { 'flags': flags, 'do_cache': True }
