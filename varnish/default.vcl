vcl 4.0;

backend servers {
    .host = "192.168.56.10";
    .port = "80";
}
sub vcl_backend_response {
  # cache everything for 5 minutes, ignoring any cache headers
  set beresp.ttl = 30m;
}