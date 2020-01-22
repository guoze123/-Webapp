// if (
//   getCookie("phoneNumber") == null
// ) {
//   location.href = base+"/common/userLogin";
// }
var role="";
if (getCookie("phoneNumber") != null) {
  $(".userName").html(getCookie("employeeName"));
  $(".userJob").html(getCookie("job"));
  role=getCookie("role")
}

var user;
var urlConfig = {
  "1_0": base + "/common/storeManagement", // 店铺管理
  "2_0": base + "/common/entryInventory", // 入库
  "2_1": base + "/common/allocate", // 调拨
  "2_2": base + "/common/salesRecord", // 销售记录
  "3_0": base + "/common/onboarding", // 入职
  "3_1": base + "/common/departure", // 离职
  "4_0": base + "/common/spendingManagement", // 开支管理
  "5_0": base + "/common/commodityManagement", // 商品管理
  "6_0": base + "/common/compayStatistical", // 公司
  "6_1": base + "/common/storeStatistical", // 店铺
  "6_2": base + "/common/paymentStatistical", // 支付情况
  "6_3": base + "/common/spendingStatistical", // 开支统计
  "7_0": base + "/common/performance", // 绩效管理
  "7_1": base + "/common/storeTarget", // 店铺目标值
  "7_2": base + "/common/storeGrade", // 店铺等级
  "7_3": base + "/common/waresDiscount" // 商品折扣配置
};
ajax_data(
  "/competence/getCompetence",
  {
    async: false,
    type: "post",
    params: { phoneNumber: getCookie("phoneNumber") },
    contentType: "application/x-www-form-urlencoded"
  },
  function(res) {
    var submenu = res.subObj;
    for (let i in submenu) {
      let arys = submenu[i].obj;
      let sbuArys = submenu[i].subObj;
      for (let k in arys) {
        for (let n in sbuArys[arys[k].id]["obj"]) {
          sbuArys[arys[k].id]["obj"][n].purview =
            sbuArys[arys[k].id]["subObj"][sbuArys[arys[k].id]["obj"][n].id];
          sbuArys[arys[k].id]["obj"][n].url_id =
            arys[k].id + "_" + sbuArys[arys[k].id]["obj"][n]["id"];
        }
        arys[k].children = sbuArys[arys[k].id]["obj"];
      }
    }
    user = res.obj;
    for (let n in user) {
      user[n]["menu"] = submenu[user[n]["id"]]["obj"];
      for (let j in user[n].menu) {
        if (user[n].menu[j]["children"].length == 1) {
          user[n].menu[j]["url_id"] = user[n].menu[j]["children"][0]["url_id"];
          user[n].menu[j]["purview"] =
            user[n].menu[j]["children"][0]["purview"];
          user[n].menu[j]["children"] = [];
        } else {
          user[n].menu[j]["url_id"] = "";
        }
      }
    }
  }
);


let menuAdmin=[];
if(user.length){
  user.forEach(function(item) {
    if(item.id == role){
      menuAdmin=item.menu
    }
  })
}
var menuHtml = ``;
for (let i = 0; i < menuAdmin.length; i++) {
  if(menuAdmin[i].id == "0"){
if(menuAdmin.length){
      $("#content-main iframe").attr("src", `main.html?purview=${menuAdmin[i].purview}`);
}else{
  $("#content-main iframe").attr("src", "");
}
    continue 
  }

  function buildChildHtml(childrenList) {
    let childHtml = "";
    if (!childrenList.length) {
      return "";
    } else {
      for (let i in childrenList) {
        childHtml += `
                    <li>
                     <a class="J_menuItem" href="${
                       urlConfig[childrenList[i].url_id]
                     }?purview=${childrenList[i].purview}" data-index="${
          childrenList[i].url_id
        }">${childrenList[i].name}</a>
                    </li>
                    `;
      }
    }
    return childHtml;
  }
  menuHtml += `
                <li>
                    <a class="${
                      menuAdmin[i].children.length > 0 ? "" : "J_menuItem"
                    }" 
                      href="${
                        menuAdmin[i].children.length > 0
                          ? "#"
                          : `${urlConfig[menuAdmin[i].url_id]}?purview=${
                              menuAdmin[i].purview
                            }`
                      }" data-index="${menuAdmin[i].id}">
                          
                        <span class="nav-label">${menuAdmin[i].name}</span>
                        <span class="fa arrow"></span>
                    </a>
                    ${
                      menuAdmin[i].children.length > 0
                        ? ` <ul class="nav nav-second-level">
                        ${buildChildHtml(menuAdmin[i].children)}
                         </ul>`
                        : ""
                    }
                </li>
                `;
}
$("#side-menu").append(menuHtml);
function logout() {
  ajax_data(
    "/common/logout",
    {
      params: {
        phoneNumber: getCookie("phoneNumber")
      },
      type: "post",
      contentType: "application/x-www-form-urlencoded;charset=utf-8"
    },
    function(res) {
      if (res.resultCode > -1) {
        delCookie("phoneNumber");
        delCookie("employeeName");
        delCookie("job");
        delCookie("ownerId");
        delCookie("employeeId");
        clearCookie();
        location.href = base+"/common/userLogin";
      }
    }
  );
}
