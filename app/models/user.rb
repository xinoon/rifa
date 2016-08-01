class User < ActiveRecord::Base
  include AASM

  def self.ventas
    self.where(state: "ocupado").count
  end

  aasm :column => :state do
    state :vacio, :initial => true
    state :reservado
    state :ocupado

    event :reservar do
     transitions :from => :vacio, :to => :reservado
    end

    event :cancelar do
     transitions :from => :reservado, :to => :vacio
    end

    event :confirmar do
     transitions :from => :reservado, :to => :ocupado
    end
  end

end
