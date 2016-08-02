class User < ActiveRecord::Base
  include AASM

  def self.ventas
    self.where(state: "ocupado").count
  end

  def self.porcentaje
    ((self.where(state: "ocupado").count * 100) / 200)
  end

  aasm :column => :state do
    state :vacio, :initial => true
    state :reservado
    state :ocupado

    event :reservar do
     transitions :from => :vacio, :to => :reservado
    end

    event :cancelar do
     transitions :from => [:reservado, :ocupado], :to => :vacio
    end

    event :confirmar do
     transitions :from => :reservado, :to => :ocupado
    end
  end

end
