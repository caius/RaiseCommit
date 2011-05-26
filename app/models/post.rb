class Post < ActiveRecord::Base
  attr_accessor :trigger_error

  def history
    @history ||= []
  end
  attr_writer :history

  after_save :saved

  after_commit :committed

  def saved
    self.history << :saved
  end

  def committed
    raise(StandardError) if trigger_error
    self.history << :committed
  end

end
