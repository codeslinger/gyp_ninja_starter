# vim:set ts=2 sw=2 et syn=python:
{
  'target_defaults': {
    'default_configuration': 'Debug',
    'configurations': {
      'Debug': {
        'defines': ['DEBUG', '_DEBUG'],
        'xcode_settings': {
          'WARNING_CFLAGS': ['-Wall', '-Werror'],
        },
      },
      'Release': {
        'xcode_settings': {
          'WARNING_CFLAGS': ['-Wall', '-Werror'],
        },
      },
    }
  },
  'targets': [{
    'target_name': 'webserver',
    'type': 'executable',
    'include_dirs': ['include'],
    'sources': [
      'src/main.c'
    ],
    'conditions': [
      ['OS != "win"', {
        'defines': ['POSIX'],
      }],
    ],
  }],
}
