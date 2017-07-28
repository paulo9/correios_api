module CorreiosECT
  module Resource
    class Plp
      include ActiveData::Model

      attribute :sender, type: Object
      attribute :postages, type: Array

      def get_xml
        objetos = objeto_postal
        xml = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><correioslog><tipo_arquivo>Postagem</tipo_arquivo><versao_arquivo>2.3</versao_arquivo><plp><id_plp/><valor_global/><mcu_unidade_postagem/><nome_unidade_postagem/><cartao_postagem>#{CorreiosECT.card}</cartao_postagem></plp><remetente><numero_contrato>#{CorreiosECT.contract}</numero_contrato><numero_diretoria>10</numero_diretoria><codigo_administrativo>#{CorreiosECT.administrative_code}</codigo_administrativo><nome_remetente><![CDATA[#{sender.name}]]></nome_remetente><logradouro_remetente><![CDATA[#{sender.street}]]></logradouro_remetente><numero_remetente><![CDATA[#{sender.number}]]></numero_remetente><complemento_remetente><![CDATA[#{sender.complement}]]></complemento_remetente><bairro_remetente><![CDATA[#{sender.district}]]></bairro_remetente><cep_remetente><![CDATA[#{sender.zip_code}]]></cep_remetente><cidade_remetente><![CDATA[#{sender.city}]]></cidade_remetente><uf_remetente>#{sender.state}</uf_remetente><telefone_remetente><![CDATA[#{sender.phone}]]></telefone_remetente><fax_remetente><![CDATA[]]></fax_remetente><email_remetente><![CDATA[#{sender.email}]]></email_remetente></remetente><forma_pagamento/>#{objetos}</correioslog>"
      end


      def objeto_postal
        obj = ""

        postages.each do |postage|
          service = sprintf('%05d', postage.service)
          obj << "<objeto_postal><numero_etiqueta>#{postage.ticket}</numero_etiqueta><codigo_objeto_cliente/><codigo_servico_postagem>#{service}</codigo_servico_postagem><cubagem>0,0000</cubagem><peso>#{postage.weight}</peso><rt1/><rt2/><destinatario><nome_destinatario><![CDATA[#{postage.receiver.name}]]></nome_destinatario><telefone_destinatario><![CDATA[#{postage.receiver.phone}]]></telefone_destinatario><celular_destinatario><![CDATA[#{postage.receiver.phone}]]></celular_destinatario><email_destinatario><![CDATA[#{postage.receiver.email}]]></email_destinatario><logradouro_destinatario><![CDATA[#{postage.receiver.street}]]></logradouro_destinatario><complemento_destinatario><![CDATA[#{postage.receiver.complement}]]></complemento_destinatario><numero_end_destinatario><![CDATA[#{postage.receiver.number}]]></numero_end_destinatario></destinatario><nacional><bairro_destinatario><![CDATA[#{postage.receiver.district}]]></bairro_destinatario><cidade_destinatario><![CDATA[#{postage.receiver.city}]]></cidade_destinatario><uf_destinatario>#{postage.receiver.state}</uf_destinatario><cep_destinatario><![CDATA[#{postage.receiver.zip_code}]]></cep_destinatario><codigo_usuario_postal/><centro_custo_cliente/><numero_nota_fiscal>#{postage.invoice}</numero_nota_fiscal><serie_nota_fiscal/><valor_nota_fiscal/><natureza_nota_fiscal/><descricao_objeto><![CDATA[#{postage.receiver.text}]]></descricao_objeto><valor_a_cobrar>0</valor_a_cobrar></nacional><servico_adicional><codigo_servico_adicional>025</codigo_servico_adicional><valor_declarado>0,00</valor_declarado></servico_adicional><dimensao_objeto><tipo_objeto>#{postage.type_object}</tipo_objeto><dimensao_altura>#{postage.height}</dimensao_altura><dimensao_largura>#{postage.width}</dimensao_largura><dimensao_comprimento>#{postage.length}</dimensao_comprimento><dimensao_diametro>#{postage.diameter}</dimensao_diametro></dimensao_objeto><data_postagem_sara/><status_processamento>0</status_processamento><numero_comprovante_postagem/><valor_cobrado/></objeto_postal>"
        end

        return obj
      end
    end
  end
end