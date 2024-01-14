$(document).ready(function () {
  // Activate tooltip
  $('[data-toggle="tooltip"]').tooltip();

  const transformToObj = (objRepr) => {
      let match = objRepr.match(/\{(.+?)\}/);
      let keyValueString = match[1];
      let keyValuePairs = keyValueString.split(', ');
      let jsObj = {};
      for (const pair of keyValuePairs){
        let keyValueArray = pair.split('=');
        if (keyValueArray.length === 2) {
            let [key, value] = keyValueArray;
            value = value.replace(/\'/g, '');
            jsObj[key] = isNaN(value) ? value : Number(value);
        }
      }
      return jsObj
  }

  // Select/Deselect checkboxes
  var checkbox = $('table tbody input[type="checkbox"]');
  $("#selectAll").click(function () {
    if (this.checked) {
      checkbox.each(function () {
        this.checked = true;
      });
    } else {
      checkbox.each(function () {
        this.checked = false;
      });
    }
  });
  checkbox.click(function () {
    if (!this.checked) {
      $("#selectAll").prop("checked", false);
    }
  });

  $(document).on("click", ".delete", function () {
      document.querySelector("input[id*='deleteStudentIdHidden']").value = $(this).data('student-id')
  });

  $(document).on("click", ".edit", function () {
        const student = transformToObj($(this).data('student'));
        Object.keys(student).forEach(key => {
            document.querySelector(`input[id*='${key}Edit']`).value = student[key];
        });
    });
});
