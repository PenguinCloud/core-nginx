/* // Need to create an authentication proxy in python to replace this.
<?php
$username = $_POST["name"]; # in our current example, this will be 'john'
$password = $_POST["psk"]; # in our current example, this will be 'supersecret'

$valid_users = file("/etc/pmg/users")

if ($valid_users[$username] == $password) {
  http_response_code(201); # return 201 "Created"
} else {
  http_response_code(404); # return 404 "Not Found"
}

  function connect_AD()
  {
    $ldap_server = "ldap://ldap.penguinzmedia.group" ;
    $ldap_user   = "uid=$username,ou=people,dc=penguinzmedia,dc=group" ;
    $ldap_pass   = $password ;

    $ad = ldap_connect($ldap_server) ;
    ldap_set_option($ad, LDAP_OPT_PROTOCOL_VERSION, 3) ;
    $bound = ldap_bind($ad, $ldap_user, $ldap_pass);

    return $ad ;
  }

?>
*/