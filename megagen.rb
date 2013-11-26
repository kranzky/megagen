#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)

module MegaGen
  def self.logger
  end

  def self.progress
  end

  def self.go!
    require './books'
    require './model'
    require './world'
    require './story'
    require './novel'

    _books = Book.retrieve

    puts _books.join('|')

    _model = Model.new
    _model.learn!(_books)

    _world = World.new(_model)
    _world.build!

    _story = Story.new(_world)
    _story.create!

    puts _story

    _novel = Novel.new(_model, _story)
    _novel.write!
    _novel.publish!
  end
end

MegaGen.go!
