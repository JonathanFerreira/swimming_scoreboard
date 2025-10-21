# Pagy configuration
# See https://ddnexus.github.io/pagy/how-to#global-configuration

# Items per page
Pagy::DEFAULT[:limit] = 10

# How many page links to show in the nav
Pagy::DEFAULT[:size] = 7

# Better user experience handled automatically
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page

# I18n support
require 'pagy/extras/i18n'

# Configure responsive breakpoints
Pagy::DEFAULT[:breakpoints] = { 0 => [1,2,2,1], 540 => [2,3,3,2], 720 => [3,4,4,3] }
