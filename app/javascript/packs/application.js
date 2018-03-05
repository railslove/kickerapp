/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import I18n from "i18n-js"

I18n.defaultLocale = 'de'
I18n.locale = document.documentElement.lang
I18n.translations = {}
I18n.translations.de = require('json-loader!yaml-loader!../../../config/locales/js.de.yml').de
I18n.translations.en = require('json-loader!yaml-loader!../../../config/locales/js.en.yml').en

// Support component names relative to this directory:
var componentRequireContext = require.context('components', true)
var ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)
