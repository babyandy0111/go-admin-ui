/**
 * database64 to 2進制
 *
 * @param  {[String]} data dataURL 的格式為 “data:image/png;base64,****”,逗號之前都是一些说明性的文字，只需要逗號之後的就行了
 * @param  {[String]} mime [description]
 * @return {[blob]}      [description]
 */
export default function(data, mime) {
  data = data.split(',')[1]
  data = window.atob(data)
  var ia = new Uint8Array(data.length)
  for (var i = 0; i < data.length; i++) {
    ia[i] = data.charCodeAt(i)
  }
  // canvas.toDataURL 默認格式就是 image/png
  return new Blob([ia], {
    type: mime
  })
}
