// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@fortawesome/fontawesome-free/css/all"
require("jquery")
import "bootstrap"
import "bootstrap-icons/font/bootstrap-icons.css"
import "bootstrap-sass"
import "./author"
import "./preview_image"
require("easy-autocomplete")
require("./sb-admin-2")
global.toastr = require("toastr")
Rails.start()
Turbolinks.start()
ActiveStorage.start()
