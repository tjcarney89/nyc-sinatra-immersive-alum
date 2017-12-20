require 'pry'
class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      @figure.titles << title
    end

    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
      @figure.landmarks << landmark
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    if !params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      @figure.titles << title
    end

    if !params["landmark"]["name"].empty? && !params["landmark"]["year_completed"].empty?
      landmark = Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
      @figure.landmarks << landmark
    elsif !params["landmark"]["name"].empty? && params["landmark"]["year_completed"].empty?
      landmark = Landmark.create(name: params["landmark"]["name"], year_completed: 2017)
      @figure.landmarks << landmark
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end



end
