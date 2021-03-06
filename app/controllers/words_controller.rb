class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /words
  # GET /words.json
  def index
    @words = current_user.word.paginate(:page => params[:page], :per_page => 100)
  end
  
  def not_memorize
    @words = current_user.word.not_memorize.paginate(:page => params[:page], :per_page => 100)
    render "index"
  end
  
  def recent_memorize
    @words = current_user.word.memorize.recent_memorize.paginate(:page => params[:page], :per_page => 100)
    render "index"
  end
  
  def many_count
    @words = current_user.word.many_count.paginate(:page => params[:page], :per_page => 100)
    render "index"
  end
  
  def recent_add
    @words = current_user.word.recent_add.paginate(:page => params[:page], :per_page => 100)
    render "index"
  end
  

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = current_user.word.new
  end

  # GET /words/1/edit
  def edit
  end
  
  # GET /words/1/edit
  def memorize
    @word = Word.find(params[:id])
    @word.memorize_count += 1
    @word.last_memorize_date = Time.new
    @flg = false
    @flg = @word.save!
    #render :text => @word.to_yaml
    respond_to do |format|
      format.html { redirect_to words_url }
      format.js 
    end
  end

  # POST /words
  # POST /words.json
  def create
    @word = current_user.word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render action: 'show', status: :created, location: @word }
      else
        format.html { render action: 'new' }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:userid, :word, :translate, :count, :memorize_count, :last_memorize_date)
    end
end
