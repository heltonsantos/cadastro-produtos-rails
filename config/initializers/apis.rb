
case
when Rails.env == 'development'

  $EMAIL_SERVICE_API = "http://localhost:3500/api/v1/";

when Rails.env == 'test'

  $EMAIL_SERVICE_API = "http://teste.com/api/v1/";

when Rails.env == 'production'

  $EMAIL_SERVICE_API = "";

else
	
	$EMAIL_SERVICE_API = "http://localhost:3500/api/v1/";

end
 