Client.create!(:name => 'Sabor Natural Ltda', :start_at => Time.current, 
               :active => true, :valid_until => Time.now + 1.year,
               :users_license => 5)
               
Company.create!(:name => 'Sabor Natural Ltda', :active => true)
Company.create!(:name => 'Anadata Sistemas', :active => true)

Role.create!(:name => 'gestor')

User.create!(:login => 'admin', :password => '1234', :password_confirmation => '1234',
             :company_id => 1, :email => 'marcioa1@gmail.com',
             :preferred_language => 'pt-BR', :role_id => 1)