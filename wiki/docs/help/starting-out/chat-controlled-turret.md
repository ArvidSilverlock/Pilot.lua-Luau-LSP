# Chat Controlled Turret

This project will demonstrate how to use a [`Microphone`](/objects/Microphone) to set the [`Seek`](/objects/Gyro#Seek) configuration of a [`Gyro`](/objects/Gyro).

![Turret](/image/examples/turret/structure.png)

**_Special configurations:_**

- Microcontroller: **StartOnSpawn** is **true**
- Gyro: **TriggerWhenSeeked** is **true**

```lua
local microphone = assert(Network:GetPart("Microphone"), "no microphone connected")
local gyro = assert(Network:GetPart("Gyro"), "no gyro connected")

-- NOTE: this does not filter for messages from you specifically,
-- nor does it check for a prefix.
-- (exercise left to the reader)
microphone.Chatted:Connect(function(userId, message)
	gyro.Seek = message
end)
```

![Turret in action](/image/examples/turret/firing.png)

Model code:

```json
{
	"m": null,
	"t": "buffer",
	"zbase64": "KLUv/WDlDb0lAGayuErAFrHGuI50FQVTdZsURVGgzILgdhx7iwyiKErBOihOVLNidaw9Kl8iaTXB+TLl8Dj+Cxuzi8Yhn2gQQG9gIeFJAzLJC6bUVrJ2p44AqACpAH+gwqrt+0XwI38wHH3/v/Cl/0CKfjTW8a9Vf5puJEmW6FnPT0ZpTc3nKURFmgD9/9I0ZXlUzJ/1fJJ5hDAZirUcozo6OnroR2P5v27xzz9CZAj6H5X1Lxeh8X85nrU8J9gxWo7/Wf9pmrroWfX/x/L87zRFkmSJPhofjf8NUn4ORERDqBKhP8BfOvnD8Q/idwHvzuXcF27d1X1XNuck4wD2QmkYlQsBqVn/XawzZZLK1mo8sID8xoMHbzMa6lH9H5Hg95IAwQH37clElQIDBVAylQVVajcOXFw0AVIuIjWEltOpJIBaaRlQOingVBpFU4ByFJr0ifxGUI8s+qSOx7YqzNa+EgsJIAx/FBrlo5/sEcd4fV6oKkrogLjhYAECA5cVHqggoBnXjHXSWquUSSpH8fs/IHw8XGzFpkajpBTLdZqkUjRpWvf98IkZXtrry3N3yg0aMFwwy5GpAth7NwyrNkH7hoXCBAkRYkgzI9ODsKTJvbYqvGNvfFY2FxNScz6Yrd0ljcpn7x0Z9+3dyBK2b+put3WqGBvb8+6emvt5tS4Lry3vxQted9u6sQy2DcMqLiZTlrDTfXsy9+3dSth5vuBXpcFbpqJR7dbF/bjvyupUOXV1c98fJOYFpsEYti3EdsDBOXV7+Eg1UGA0WcOGkdGPToV3W8fWvvLlBxAfJhVWbSq8c76gr7QD1JEDRxF5Ip1unIDCFhulGiQUjRkmGT2hGZAH7wDIlF/ph8VtdbnWKmWOogkDZHG3FesMURu0rS5wTnNGG1OplZYWL2vi3bcb+9ZIPSx4VtBM1jgTzRQgihMm0BA1a7HOtLZD4ly5aCNAETkhcF4zVysVoj6APFnoQdYBx2S1XCvRjIEbDoEGqBE5qtCJSAsKClJpDeEFhDF1VnUSgJBpLGwMUsYwFEgggdhMTmlKWugg6tKAonrb11ch6gO56SbCyGiqw6K3UOSgngyluaAZXiCs2I35QDwotj02Imjn9IZ+CSbk1KDPOCsMn0NOc3mdjwQSKfwiAfvNrgDZ9NHfaH8P/7OdoiEDLtI9BLw1u2S2rn1coHPeEQWlOMCYjXY1/KtI6O5B7wGVTJwIdjFfS28li+kLF5EO5vURgIqyMyJR92tXBPO2P6/KmsDoDDIi5YfhLzbbRUf4BJK2CGHt5JExt6mxVPYuXbNARZQ4BslZVkaHoa/08AHxj0RTydQXcryW8RIRpwmaR+FNGCw9nXswjicpoXOKsMpym7mF2VdvMvTZlcVYGkSdYV6asLLTIxxNYKUl5IcoCurGMEtyABoq8xzmHwzA1bCwgB8x9Jw0zwKSiR6ziVNKDf5eJ22xeMns/HrFuIiUAlDr75Z3oSuhA6T7WEwToXd81ed4AB3T+/7A1euBhrSw0px/mqFt9tvlxUFCdw6IWSNKP4YUlP3fHXPhbZ0+YzYz+mqat2TzKefm9TGNCcxjjiEP5x4fuHh2aR4MdDWM0Hf362HxxmBiLEBNVg0="
}
```
