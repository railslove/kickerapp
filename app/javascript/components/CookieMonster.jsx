import React from "react"
import I18n from "i18n-js"
import CookieBanner from 'react-cookie-banner'
import cookieImg from 'images/cookie.png'

const styles = {
  banner: {
    background: `rgba(52, 64, 81, 0.88) url(${cookieImg}) 20px 20px no-repeat`,
    backgroundSize: '30px 30px',
    backgroundColor: '',
    fontSize: '15px',
    fontWeight: 600,
    position: 'fixed',
    top: 0,
    height: 'auto'
  },
  button: {
    border: '1px solid white',
    borderRadius: 4,
    height: 32,
    lineHeight: '32px',
    background: 'transparent',
    color: 'white',
    fontSize: '14px',
    fontWeight: 600,
    opacity: 1,
    right: 20,
    marginTop: -18,
    position: 'initial',
    marginBottom: '20px'
  },
  message: {
    display: 'block',
    padding: '20px',
    paddingLeft: '65px',
    lineHeight: 1.3,
    textAlign: 'justify',
    color: 'white'
  },
  link: {
    textDecoration: 'underline',
    fontWeight: 'bold'
  }
}

const CookieMonster = () => (
  <CookieBanner
    styles={styles}
    message={I18n.t('cookies.text')}
    buttonMessage={I18n.t('cookies.ok')}
    onAccept={() => {}}
    cookie="user-has-accepted-cookies"
    dismissOnScroll={false}
    link={<a href="https://kicker.cool/privacy_policy">{I18n.t('cookies.more')}</a>}
  />
)

export default CookieMonster
