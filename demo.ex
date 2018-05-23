
include Wininet.ew
include std/net/url.e
include std/pretty.e

procedure print_r( object value, sequence name = "", sequence options = {2} )
	
	if length( name ) then
		printf( 1, "%s = ", {name} )
	end if
	
	pretty_print( 1, value, options )
	puts( 1, "\n" )
	
end procedure

public function HttpGetRequest( sequence url )
	
	atom flags = INTERNET_FLAG_NO_UI
	atom port = INTERNET_DEFAULT_HTTP_PORT
	
	sequence parsed = url:parse( url )
	
	if equal( parsed[1], "https" ) then
		flags += INTERNET_FLAG_SECURE
		port = INTERNET_DEFAULT_HTTPS_PORT
	end if
	
	atom ih = InternetOpen( "Mozilla/4.0 (compatible)", INTERNET_OPEN_TYPE_PRECONFIG )
	atom ch = InternetConnect( ih, parsed[2], port )
	atom req = HttpOpenRequest( ch, "GET", parsed[4], , , , flags )
	
	object data = {}
	
	if HttpSendRequest( req ) then
		data = InternetReadFile( req )
	end if
	
	InternetCloseHandle( req )
	InternetCloseHandle( ch )
	InternetCloseHandle( ih )
	
	return data
end function

procedure main()
	
	object data = HttpGetRequest( "https://myhtf.net/server-ip.txt" )
	print_r( data, "data" )
	
end procedure

main()
