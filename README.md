# Credomatic Payments

Gema para la conexion al servicio de pagos de Credomatic Costa Rica. Encapsula el endpoint de pagos de Credomatic, y permite crear ventas y autorizaciones.

## Instalación

Agregar la siguiente linea en su Gemfile:

```ruby
gem 'credomatic-payments'
```

Luego ejecute:

    $ bundle

O instalelo usted mismo:

    $ gem install credomatic-payments

## Uso

Para poder utilizar la geme debe crear una instancia de la clase Transactions, dicha clase se encuentra dentro del modulo Credomatic::Payments

```ruby
transaction = Transactions.new(KEY_ID, KEY)
```

Una vez creada la instancia basta con llamar al metodo generate_transaction, con los parametros adecuados para recibir una respuesta por parte del servidor de Credomatic.

```ruby
transaction.generate_transaction(TRANSACTION_TYPE, REDIRECT_URL, CARD_NUMBER, CARD_EXPERATION, AMOUNT, ORDERID, CVV, ADDRESS, PROCESSOR_ID)
```

A continuacion se describen cada uno de los parametros:

- TRANSACTION_TYPE: tipo de transaccion, actualmente se soportan el tipo "sale" y "auth"
- REDIRECT_URL: opcional, si utiliza el redirect url, su pagina web debera tener un url que soporte get donde el servidor de credomatic, brindara la respuesta. Si no se pasa un redirect url, se activara el modo api, y el response sera procesado por la gema.
- CARD_NUMBER: Número de tarjeta.
- AMOUNT: valor de la venta.
- ORDERID: valor opcional, es un id que se le quiera dar a la orden.
- CVV: código de seguridad de la tarjeta.
- ADDRESS: valor opcional, direccion del dueño de la tarjeta.
- PROCESSOR_ID: valor opcional, Identificador de la terminal con la cual desea realizar la autorización, credomatic determinará si se debe pasar algun valor en este parámetro.

### Respuesta modo API

En caso de no utilizar un redirect url, la gema sera la encargada de procesar la respuesta del servidor, acontinuacion se detalla la respuesta.

```ruby
response = transaction.generate_transaction(TRANSACTION_TYPE, REDIRECT_URL, CARD_NUMBER, CARD_EXPERATION, AMOUNT, ORDERID, CVV, ADDRESS, PROCESSOR_ID)
```

La variable response es un hash, con las siguientes llaves:

- response
- responsetext
- authcode
- transactionid
- avsresponse
- cvvresponse
- orderid
- type
- response_code

Basándonos en la documentación de credomatic, los valores de dichas variables se resumen en la siguiente tabla:

Response

| Codigo 	|                         Valor                         	|
|:------:	|:-----------------------------------------------------:	|
|    1   	| Transacción Aprobada                                  	|
|    2   	| Transacción Denegada                                  	|
|    3   	| Error en datos de la transacción o error del sistema. 	 |

Response Code

| Codigo 	|                   Valor                   	|
|:------:	|:-----------------------------------------:	|
|   100  	| Transacción Aprobada                      	|
|   200  	| Transacción declinada por el Autorizador. 	 |
|   300  	| Transacción declinada por el Sistema.     	|

CVV Response

| Codigo 	|                                 Valor                                	|
|:------:	|:--------------------------------------------------------------------:	|
|    M   	| CVV2/CVC2 Match                                                      	|
|    N   	| CVV2/CVC2 No Match                                                   	|
|    P   	| Not Processed                                                        	|
|    S   	| Merchant has indicated that CVV2/CVC2 is not present on card         	|
|    U   	| Issuer is not certified and/or has not provided Visa encryption keys 	|

AVS Response

| Codigo 	|                 Valor                	|
|:------:	|:------------------------------------:	|
|    X   	| Exact match, 9-character numeric ZIP 	|
|    Y   	| Exact match, 5-character numeric ZIP 	|
|    D   	| "                                    	|
|    M   	| "                                    	|
|    A   	| Address match only                   	|
|    B   	| "                                    	|
|    W   	| 9-character numeric ZIP match only   	|
|    Z   	| 5-character Zip match only           	|
|    P   	| "                                    	|
|    L   	| "                                    	|
|    N   	| No address or ZIP match              	|
|    C   	| "                                    	|
|    U   	| Address unavailable                  	|
|    G   	| Non-U.S. Issuer does not participate 	|
|    I   	| "                                    	|
|    R   	| Issuer system unavailable            	|
|    E   	| Not a mail/phone order               	|
|    S   	| Service not supported                	|
|    0   	| AVS Not Available                    	|
|    O   	| "                                    	|
|    B   	| "                                    	|

## Licencia

Esta gema es open source bajo los estatutos de la licencia [MIT License](https://opensource.org/licenses/MIT).
