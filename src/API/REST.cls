Class Simple.Api.Rest Extends %CSP.REST
{

/// Docs here https://cedocs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST_services#GREST_urlmap
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/test" Method="GET" Call="Test"/>

  <Route Url="/gun/getall" Method="GET" Call="GunGetAll"/>
  <Route Url="/gun/getselectlist" Method="GET" Call="GunGetSelectList"/>
  <Route Url="/gun/delete" Method="DELETE" Call="GunDelete"/>
  <Route Url="/gun/add" Method="POST" Call="GunAdd"/>
  <Route Url="/gun/edit" Method="POST" Call="GunEdit"/>
  
  <Route Url="/customer/getall" Method="GET" Call="CustomerGetAll"/>
  <Route Url="/customer/getnameselectlist" Method="GET" Call="CustomerGetNameSelectList"/>
  <Route Url="/customer/delete" Method="DELETE" Call="CustomerDelete"/>
  <Route Url="/customer/add" Method="POST" Call="CustomerAdd"/>
  <Route Url="/customer/edit" Method="POST" Call="CustomerEdit"/>

  <Route Url="/saler/getall" Method="GET" Call="SalerGetAll"/>
  <Route Url="/saler/getnameselectlist" Method="GET" Call="SalerGetNameSelectList"/>
  <Route Url="/saler/delete" Method="DELETE" Call="SalerDelete"/>
  <Route Url="/saler/add" Method="POST" Call="SalerAdd"/>
  <Route Url="/saler/edit" Method="POST" Call="SalerEdit"/>

  <Route Url="/order/getall" Method="GET" Call="OrderGetAll"/>
  <Route Url="/order/getnameselectlist" Method="GET" Call="OrderGetNameSelectList"/>
  <Route Url="/order/delete" Method="DELETE" Call="OrderDelete"/>
  <Route Url="/order/add" Method="POST" Call="OrderAdd"/>
  <Route Url="/order/edit" Method="POST" Call="OrderEdit"/>
</Routes>
}

ClassMethod Test() As %Status
{
  write "hello this is test"
  return $$$OK
}

ClassMethod GunGetAll() As %Status
{
  Try {
    write ##class(Simple.Gun).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod GunGetSelectList() As %Status
{
  Try {
    write ##class(Simple.Gun).getSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod GunDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(Simple.Gun).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod GunAdd() As %Status
{
  set result = ##class(Simple.Gun).add(%request)
  write result
  return $$$OK
}

ClassMethod GunEdit() As %Status
{
  set result = ##class(Simple.Gun).edit(%request)
  write result
  return $$$OK
}

ClassMethod CustomerGetAll() As %Status
{
  Try {
    write ##class(Simple.Customer).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod CustomerGetNameSelectList() As %Status
{
  Try {
    write ##class(Simple.Customer).getNameSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod CustomerDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(Simple.Customer).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod CustomerAdd() As %Status
{
  set result = ##class(Simple.Customer).add(%request)
  write result
  return $$$OK
}

ClassMethod CustomerEdit() As %Status
{
  set result = ##class(Simple.Customer).edit(%request)
  write result
  return $$$OK
}

ClassMethod SalerGetAll() As %Status
{
  Try {
    write ##class(Simple.Saler).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod SalerGetNameSelectList() As %Status
{
  Try {
    write ##class(Simple.Saler).getNameSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod SalerDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(Simple.Saler).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod SalerAdd() As %Status
{
  set result = ##class(Simple.Saler).add(%request)
  write result
  return $$$OK
}

ClassMethod SalerEdit() As %Status
{
  set result = ##class(Simple.Saler).edit(%request)
  write result
  return $$$OK
}

ClassMethod OrderGetAll() As %Status
{
  Try {
    write ##class(Simple.Order).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod OrderGetNameSelectList() As %Status
{
  Try {
    write ##class(Simple.Order).getNameSelectList()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod OrderDelete() As %Status
{
  set id = %request.Get("id")
  set deleteResult = ##class(Simple.Order).delete(id)
  write deleteResult
  return $$$OK
}

ClassMethod OrderAdd() As %Status
{
  set result = ##class(Simple.Order).add(%request)
  write result
  return $$$OK
}

ClassMethod OrderEdit() As %Status
{
  set result = ##class(Simple.Order).edit(%request)
  write result
  return $$$OK
}

ClassMethod ResultLoad() As %Status
{
  set result = ##class(Simple.Result).loadTemplate()
  write result
  return $$$OK
}

ClassMethod ResultGetAll() As %Status
{
  Try {
    write ##class(Simple.Result).getAll()
    return $$$OK
  } Catch {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
    Return $$$ERROR(500)
  }
}

ClassMethod ResultSet() As %Status
{
  set result = ##class(Simple.Result).setResult(%request)
  write result
  return $$$OK
}

}
