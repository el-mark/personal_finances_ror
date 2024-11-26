# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "color-modes", to: "color-modes.js"
pin "bootstrap", to: "bootstrap.bundle.min.js"
pin "dashboard", to: "dashboard.js"

pin_all_from "app/javascript/controllers", under: "controllers"
