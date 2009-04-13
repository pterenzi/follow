require 'digest/sha1'

class Usuario < ActiveRecord::Base
  # Relacionamentos

  require 'brazilian-rails'

  usar_como_cpf :cpf

  has_many :projetos, :through=> :projetos_usuarios

  has_many :projetos_usuarios

  has_many :recados

  has_many :tarefas
  
  

  belongs_to :categoria



  # Validações

  humanize_attributes(:categoria_id => "Tipo do Usuário"  )

 
 
 validates_presence_of :categoria_id, :message=>"não pode ficar em branco!"

  validates_presence_of :cpf, :message=>"não pode ficar em branco!"
  validates_presence_of :nome, :message=>"não pode ficar em branco!"

  validates_length_of  :nome, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

  validates_length_of  :cargo, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

  validates_length_of  :endereco, :maximum=>128, :message=>"não pode exeder os 128 caracteres!"

  validates_length_of  :bairro, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

  validates_length_of  :municipio, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

  validates_length_of  :uf, :maximum=>2, :message=>"não pode exeder os 2 caracteres!"

  validates_length_of  :email, :maximum=>128, :message=>"não pode exeder os 128 caracteres!"

  validates_length_of  :gerente, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"



#esquema padrao de controle de acesso

 validates_presence_of     :login, :message=>"não pode ficar em branco!"
 validates_uniqueness_of :login, :message=>"já existe, por favor escolha outro!"

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  def validate
    errors.add_to_base("Senha Invalida") if hashed_password.blank?
  end



  def self.authenticate(login, password)
    usuario = self.find_by_login(login)
    if usuario
      expected_password = encrypted_password(password, usuario.salt)
      if usuario.hashed_password != expected_password
        usuario = nil
      end
    end
    usuario
  end


  # 'password' is a virtual attribute

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Usuario.encrypted_password(self.password, self.salt)
  end




  private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt  # 'wibble' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end




  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end








end

