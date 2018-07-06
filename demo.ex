
include Wininet.ew
include std/pretty.e

constant UNITS = {"bytes","KiB","MiB"}

function format_size( atom size )
	
	integer index = 1
	
	while size > 1024 do
		size /= 1024
		index += 1
	end while
	
	return sprintf( "%0.2f %s", {size,UNITS[index]} )
end function

procedure download_file( sequence url )
	
	sequence data = HttpGetRequest( url )
	sequence size = format_size( length(data) )
	
	printf( 1, "%10s %s\n", {size,url} )
	
end procedure

procedure main()
	
	download_file( "https://openeuphoria.org/index.wc" )
	download_file( "https://openeuphoria.org/forum/" )
	download_file( "https://sourceforge.net/projects/rapideuphoria/files/Euphoria/4.0.5/euphoria-4.0.5.pdf" )
	download_file( "https://sourceforge.net/projects/rapideuphoria/files/Euphoria/4.0.5/euphoria-4.0.5-html.zip" )
	download_file( "https://sourceforge.net/projects/rapideuphoria/files/Euphoria/4.0.5/euphoria_4.0.5_i386.deb" )
	download_file( "https://sourceforge.net/projects/rapideuphoria/files/Euphoria/4.0.5/euphoria-4.0.5.exe" )
	download_file( "https://sourceforge.net/projects/rapideuphoria/files/Euphoria/4.1.0-beta2/euphoria-4.1.0-x86.exe" )
	
end procedure

main()
