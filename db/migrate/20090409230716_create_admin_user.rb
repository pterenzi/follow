class CreateAdminUser < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO `usuarios` (`id`,`categoria_id`,`nome`,`cargo`,`pass`,`endereco`,`bairro`,`municipio`,`uf`,`cpf`,`email`,`gerente`,`login`,`hashed_password`,`salt`,`created_at`,`updated_at`,`ativado`) VALUES 
     (2,3,'WILSON AQUINO DE MAGALHÃES','Tecnico',NULL,'Rua tra la la','mexericas','Embu','SP','15755319847','willinos@gmail.com','mano  brown','willinos','3671f38ce6d9f377d9fb7ba5981b45dbf5abcc42','412261000.500537961562879','2009-04-05 12:23:38','2009-04-05 15:34:30',NULL)"
    
  end
 
  def self.down
    execute "delete * from usuarios"
  end
end
