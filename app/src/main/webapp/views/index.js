$(document).ready(function () {
  const checkbox = $('table tbody input[type="checkbox"]');
  const selectAllCheckboxButton = $("#selectAll");
  const deleteSelectedRecordButton = $("#deleteSelectedButton");

  const getSelectedRecord = () => {
    const selectedLines = [];
    $('table tbody input[type="checkbox"]').each(function () {
      if (this.checked) {
        selectedLines.push(this);
      }
    });
    return selectedLines;
  };

  const transformToObj = (objRepr) => {
    let match = objRepr.match(/\{(.+?)\}/);
    let keyValueString = match[1];
    let keyValuePairs = keyValueString.split(", ");
    let jsObj = {};
    for (const pair of keyValuePairs) {
      let keyValueArray = pair.split("=");
      if (keyValueArray.length === 2) {
        let [key, value] = keyValueArray;
        value = value.replace(/\'/g, "");
        jsObj[key] = isNaN(value) ? value : Number(value);
      }
    }
    return jsObj;
  };

  const updateStateOfDeleteSelectedRecordButton = () => {
    if (getSelectedRecord().length == 0) {
      deleteSelectedRecordButton.attr("href", "");
      deleteSelectedRecordButton.attr("disabled", true);
    } else {
      deleteSelectedRecordButton.attr("href", "#deleteModal");
      deleteSelectedRecordButton.attr("disabled", false);
    }
  };

  updateStateOfDeleteSelectedRecordButton();

  // Activate tooltip
  $('[data-toggle="tooltip"]').tooltip();

  // Select/Deselect checkboxes
  selectAllCheckboxButton.click(function () {
    if (this.checked) {
      checkbox.each(function () {
        this.checked = true;
      });
    } else {
      checkbox.each(function () {
        this.checked = false;
      });
    }
    updateStateOfDeleteSelectedRecordButton();
  });

  checkbox.click(function () {
    if (!this.checked) {
      selectAllCheckboxButton.prop("checked", false);
    }
    updateStateOfDeleteSelectedRecordButton();
  });

  $(document).on("click", ".delete", function () {
    document.querySelector("input[id*='deleteStudentIdHidden']").value = [
      Number($(this).data("student-id")),
    ];
  });

  $(document).on("click", ".edit", function () {
    const student = transformToObj($(this).data("student"));
    Object.keys(student).forEach((key) => {
      document.querySelector(`input[id*='${key}Edit']`).value = student[key];
    });
  });

  deleteSelectedRecordButton.click(function () {
    const selectedIds = [];
    for (const line of getSelectedRecord()) {
      selectedIds.push(
        Number(
          line.parentElement.parentElement.parentElement.querySelector(
            ".delete"
          ).dataset["studentId"]
        )
      );
    }
    document.querySelector("input[id*='deleteStudentIdHidden']").value =
      selectedIds;
  });
});
