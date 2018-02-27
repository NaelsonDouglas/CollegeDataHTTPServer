#=using HttpServer
using Genie

Genie.REPL.new_app("HTTPServer")
=#

using HttpServer
using JSON


resourceslist = [
UFAL = Dict("Sigla"=>"UFAL","Nome"=>"Universidade federal de alagoas"),
UFBA = Dict("Sigla"=>"UFBA","Nome"=>"Universidade federal da Bahia"),
UFSE = Dict("Sigla"=>"UFSE","Nome"=>"Universidade federal de sergipe"),
UFMG = Dict("Sigla"=>"UFMG","Nome"=>"Universidade federal de Minas gerais"),
UFPE = Dict("Sigla"=>"UFPE","Nome"=>"Universidade federal de Pernambuco"),
UFRJ = Dict("Sigla"=>"UFRJ","Nome"=>"Universidade federal do Rio de Janeiro"),
PUCRJ = Dict("Sigla"=>"PUCRJ","Nome"=>"Pontifícia Universidade Católica do Rio de Janeiro"),
]

function addresource(list=resourceslist)
	resources = Dict()
	for i in resourceslist
		resources[i["Sigla"]] = i
	end
	return resources
end

colleges = addresource()

http = HttpHandler() do req::Request, res::Response	
	
	college = split(req.resource,'/')[3]

	#GET
	if (ismatch(r"^/get/",req.resource))
    	return Response(haskey(colleges,college) ? JSON.json(colleges[college]) : 404 )
    end

    #POST
    if (ismatch(r"^/post/",req.resource))
    	reqtokens = split(req.resource,"/")
    	
    	initials = reqtokens[3]
    	name = reqtokens[4]

    	if (haskey(colleges,initials))
    		return Response("HTTP ERROR 409")
    	end

    	
    	

    	newcollege = Dict("Nome" =>name , "Sigla" =>initials)

    	colleges[initials] = newcollege
    	return Response(JSON.json(colleges[initials]))
    end


    #PUT
    if (ismatch(r"^/put/",req.resource))
    	reqtokens = split(req.resource,"/")
    	initials = reqtokens[3]

    	if (haskey(colleges,initials))

    		reqtokens = split(req.resource,"/")    	
    		
    		for i=1:length(reqtokens)-1
    			if(reqtokens[i] == "Nome")
    				colleges[initials]["Nome"] = reqtokens[i+1]
    				i=i+1
    			elseif(reqtokens[i] == "Sigla")
    				colleges[initials]["Sigla"] = reqtokens[i+1]
    				i=i+1
    			end
    		end
    		return Response(JSON.json(colleges[initials]))   		
    	else
    		return Response(404)
    	end

    	
    	

    	newcollege = Dict("Nome" =>name , "Sigla" =>initials)

    	colleges[initials] = newcollege
    	return Response(JSON.json(colleges[initials]))
    end


    #DELETE
    if (ismatch(r"^/delete/",req.resource))
    	reqtokens = split(req.resource,"/")
    	initials = reqtokens[3]

    	if (haskey(colleges,initials))
  			delete!(colleges,initials)
  			return Response("OK")
    	else
    		return Response(404)
    	end
    end

end








server = Server( http )
sv = @spawn run( server, 8000 )



