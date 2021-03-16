// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import StimulusReflex from 'stimulus_reflex'
import consumer from '../channels/consumer'
import ContentLoader from "stimulus-content-loader"
import controller from './application_controller'
import Prefetch from "stimulus-prefetch"
import Carousel from "stimulus-carousel"

const application = Application.start()
application.register("carousel", Carousel)
application.register("content-loader", ContentLoader)
application.register("prefetch", Prefetch)
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
StimulusReflex.initialize(application)
StimulusReflex.debug = process.env.RAILS_ENV === 'development'
