import React from 'react'
import PropTypes from 'prop-types'

function IconBackup({ width = 18, height = 18, fill = '#00C1DE' }) {
  return (
    <svg viewBox="0 0 1024 1024" style={{ overflow: 'visible' }} width={width} height={height} xmlns="http://www.w3.org/2000/svg">
      <path d="M589.417367 0.00037a510.621451 510.621451 0 0 0-271.482709 77.763916l47.13995 75.35392A422.192546 422.192546 0 1 1 193.031793 359.569984l126.279864 47.139949-83.269911-263.569717L0 286.280062l111.48388 41.633956A511.99945 511.99945 0 1 0 589.417367 0.00037z" fill={fill}></path>
      <path d="M747.696197 294.194054a375.396597 375.396597 0 0 0-154.149835-29.591968c-120.77387 0-210.923773 46.10795-210.923773 87.053906s89.805904 86.709907 210.235774 86.709907a375.741596 375.741596 0 0 0 154.837834-29.935968c34.409963-16.515982 56.08594-37.849959 56.08594-57.117938 0-19.612979-20.989977-41.634955-56.08594-57.117939z m58.494937 370.579602v-91.526902a184.429802 184.429802 0 0 1-45.074952 28.902969 407.396562 407.396562 0 0 1-167.913819 34.408963 333.762641 333.762641 0 0 1-209.891775-59.182936v92.214901c4.129996 40.257957 92.9029 84.299909 211.267773 84.299909 118.365873 0 206.450778-44.385952 211.612773-84.989909v-4.126995z" fill={fill}></path>
      <path d="M806.191134 506.149826v-93.2469a184.429802 184.429802 0 0 1-45.074952 28.902969 407.396562 407.396562 0 0 1-167.913819 34.408963 333.762641 333.762641 0 0 1-209.891775-59.182936v92.214901c4.129996 40.257957 92.9029 84.299909 211.267773 84.299909 118.365873 0 206.450778-44.385952 211.612773-84.987908v-4.129996z" fill={fill}></path>
    </svg>
  )
}

IconBackup.propTypes = {
  width: PropTypes.number,
  height: PropTypes.number,
  fill: PropTypes.string,
}

export default IconBackup
