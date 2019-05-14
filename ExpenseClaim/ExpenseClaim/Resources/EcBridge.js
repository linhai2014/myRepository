(
  function () {
    const u = navigator.userAgent;
    const isIOS = !!u.match(/\(i[^;]+;(U;)?CPU.+Mac OS X/);
    let comFun = data => {
      let _data = JSON.stringify(data);
      try {
        return isIOS ? window.EcBridge(_data) : window.EcBridge.msgHandler(_data);
      } catch (e) {
        alert(e)
      }
    }
    let sdk = {
      getPhoneInfo() {
        let data = {
          methodsName: "getPhoneInfo",
          params: {
            hasResponse: true
          }
        };
        return comFun(data);
      },
      close() {
        //const data = {
        //  methodsName: "close"
        //};
        //comFun(data);
        location.href = "rrcc://cloase_?_param1&param2";
      },
      goPage(path, type) {
        let data = {
          methodsName: "gePage",
          params: {
            path,
            type
          }
        };
        comFun(data);
      },
      getToken() {
        let data = {
          methodsName: "getToken",
          params: {
            hasResponse: true
          }
        }
        return comFun(data);
      },
      headerStatus(status = "show", headTopbg, color) {
        let data = {
          methodsName: "headerStatus",
          params: {
            status,
            headTopbg,
            color
          }
        }
        comFun(data);
      },
      setCache(key, params) {
        let data = {
          methodsName: "setCache",
          params: {
            key,
            value: JSON.stringify(params),
            level: "app"
          }
        };
        comFun(data);
      },
      getCache(key) {
        let data = {
          methodsName: "getCache",
          params: {
            key,
            level: "app"
          }
        };
        comFun(data);
      },
      getUserInfo(userInfo) {
        let data = {
          methodsName: "getUserInfo",
          params: {
            hasResponse: true,
            data: userInfo
          }
        };
        return comFun(data);
      },
      openPhoto(max, min = 1) {
        let data = {
          methodsName: "openPhoto",
          params: {
            hasResponse: true,
            minNums: min,
            maxNumes: max
          }
        };
        return comFun(data);
      },
      sendData(proData) {
        let data = {
          methodsName: "sendData",
          params: {
            proData: proData
          }
        };
        return comFun(data);
      }
    };
    window.sdk = sdk;
  }
)(window)
