
$(document).ready(function() {

    $("#btncep").click(function(){
              
        cep = document.getElementById("control").value + "_cep"
        mun = "#"+document.getElementById("control").value + "_municipio"
        end = "#"+document.getElementById("control").value + "_endereco"
        u = "#"+document.getElementById("control").value + "_uf"
                 
        if ($.trim(document.getElementById(cep).value) != "") { 
            $("#lbcep").html(" Pesquisando cep...")
            $.getJSON("/centro_de_negocios/localizar_endereco", { cep: $("#"+cep).val()},function(json){
                if (json.retorno == 1) {
                    $(mun).val(json.cidade)
                    $(u).val(json.estado)
                    $(end).val(json.endereco).focus();
                         
                } else {
                    alert("Cep não encontrado.");
                }
                $("#lbcep").html(" Cep:")});
        } 
            else {
                alert("Informe um Cep.");
            }
        });
        });

    